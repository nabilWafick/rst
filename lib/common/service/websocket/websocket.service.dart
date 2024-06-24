import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rst/utils/utils.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketChannel? _channel;
  Timer? _reconnectTimer;
  bool _isConnected = false;
  final String _wsUrl = RSTApiConstants.wsBaseUrl ?? ''; // Adjust as needed

  // Reconnection parameters
  final int _reconnectInterval = 1500; // 5 seconds
  final int _maxReconnectAttempts = 10;
  int _reconnectAttempts = 0;

  void connect() {
    if (_isConnected) return;

    debugPrint('Attempting to connect to WebSocket...');
    try {
      _channel = WebSocketChannel.connect(Uri.parse(_wsUrl));
      _channel!.stream.listen(
        _onMessage,
        onError: _onError,
        onDone: _onDone,
      );
      _isConnected = true;
      _reconnectAttempts = 0;
      debugPrint('WebSocket connected successfully');
    } catch (e) {
      debugPrint('Error creating WebSocket connection: $e');
      _scheduleReconnect();
    }
  }

  void _onMessage(dynamic message) {
    debugPrint('Received WebSocket message: $message');
    try {
      final data = jsonDecode(message);
      final eventType = data['event'];
      final eventData = data['data'];

      switch (eventType) {
        case 'addition':
          debugPrint('Addition data: $eventData');
          break;
        case 'update':
          debugPrint('Update data: $eventData');
          break;
        case 'deletion':
          debugPrint('Deletion data: $eventData');
          break;
        default:
          debugPrint('Unknown event type: $eventType');
      }
    } catch (e) {
      debugPrint('Error processing WebSocket message: $e');
    }
  }

  void _onError(error) {
    debugPrint('WebSocket error: $error');
    _isConnected = false;
    _scheduleReconnect();
  }

  void _onDone() {
    debugPrint('WebSocket connection closed');
    _isConnected = false;
    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    if (_reconnectAttempts >= _maxReconnectAttempts) {
      debugPrint('Max reconnection attempts reached. Stopping reconnection.');
      return;
    }

    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(Duration(milliseconds: _reconnectInterval), () {
      _reconnectAttempts++;
      debugPrint('Attempting to reconnect... (Attempt $_reconnectAttempts)');
      connect();
    });
  }

  void disconnect() {
    debugPrint('Disconnecting WebSocket');
    _reconnectTimer?.cancel();
    _channel?.sink.close();
    _isConnected = false;
    _reconnectAttempts = 0;
  }

  bool get isConnected => _isConnected;
}
