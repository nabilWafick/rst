import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:rst/utils/utils.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/*
final webSocketChannel = WebSocketChannel.connect(
  Uri.parse(RSTApiConstants.wsBaseUrl ?? ''),
);
*/

void socket() {
  debugPrint('Attempting to connect to WebSocket...');
  try {
    final webSocketChannel = WebSocketChannel.connect(
      Uri.parse(
        RSTApiConstants.wsBaseUrl ?? '',
      ),
    );

    debugPrint('WebSocket connection initiated');

    webSocketChannel.stream.listen(
      (event) {
        debugPrint('Received WebSocket event: $event');
        try {
          final data = jsonDecode(event);
          final eventType = data['event'];
          final productData = data['data'];

          switch (eventType) {
            case 'addition':
              debugPrint('addition data: $productData');
              break;
            case 'update':
              debugPrint('update data: $productData');
              break;
            case 'deletion':
              debugPrint('deletion data: $productData');
              break;
            default:
              debugPrint('Unknown event type: $eventType');
          }
        } catch (e) {
          debugPrint('Error processing WebSocket event: $e');
        }
      },
      onError: (error) {
        debugPrint('WebSocket error: $error');
        //  reconnect();
      },
      onDone: () {
        debugPrint('WebSocket connection closed');
        //  reconnect();
      },
    );
  } catch (e) {
    debugPrint('Error creating WebSocket connection: $e');
    //  reconnect();
  }
}
