import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/modules/cash/cash_operations/providers/cash_operations.provider.dart';
import 'package:rst/modules/cash/cash_operations/views/widgets/card_settlements/providers/card_settlements.provider.dart';
import 'package:rst/modules/cash/collections/providers/collections.provider.dart';
import 'package:rst/modules/cash/settlements/providers/settlements.provider.dart';
import 'package:rst/modules/definitions/agents/providers/agents.provider.dart';
import 'package:rst/modules/definitions/cards/providers/cards.provider.dart';
import 'package:rst/modules/definitions/categories/providers/categories.provider.dart';
import 'package:rst/modules/definitions/collectors/providers/collectors.provider.dart';
import 'package:rst/modules/definitions/customers/providers/customers.provider.dart';
import 'package:rst/modules/definitions/economical_activities/providers/economical_activities.provider.dart';
import 'package:rst/modules/definitions/localities/providers/localities.provider.dart';
import 'package:rst/modules/definitions/personal_status/providers/personal_status.provider.dart';
import 'package:rst/modules/definitions/products/providers/products.provider.dart';
import 'package:rst/modules/definitions/types/providers/types.provider.dart';
import 'package:rst/modules/stocks/stocks/providers/stocks.provider.dart';
import 'package:rst/modules/transfers/validations/providers/validations.provider.dart';
import 'package:rst/utils/utils.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  static WebSocketService? _instance;
  final WidgetRef ref;

  factory WebSocketService({required WidgetRef ref}) {
    _instance ??= WebSocketService._internal(ref);
    return _instance!;
  }

  WebSocketService._internal(this.ref);

  WebSocketChannel? _channel;
  Timer? _reconnectTimer;
  bool _isConnected = false;
  final String _wsUrl = RSTApiConstants.wsBaseUrl ?? '';

  // Reconnection parameters
  final int _reconnectInterval = 5000;
  final int _maxReconnectAttempts = 5;
  int _reconnectAttempts = 0;

  Future<void> connect() async {
    if (_isConnected) return;

    debugPrint('Attempting to connect to WebSocket...');
    try {
      _channel = WebSocketChannel.connect(Uri.parse(_wsUrl));
      await _channel!.ready; // Wait for the connection to be established
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
      _isConnected = false;
      _scheduleReconnect();
    }
  }

  void _onMessage(dynamic message) {
    debugPrint('Received WebSocket message: $message');
    try {
      final data = jsonDecode(message);
      final eventType = data['event'] as String;
      //  final eventData = data['data'] as String;

      // get the module name since the event name is like
      // agent-addition, agent-update, agent-deletion, ...
      final module = eventType.split('-')[0];

      // reset fetching providers when a data have added, updated or deleted
      switch (module) {
        case 'agent':
          ref.invalidate(agentsListStreamProvider);
          ref.invalidate(agentsCountProvider);
          ref.invalidate(specificAgentsCountProvider);
          break;

        case 'card':
          ref.invalidate(cardsListStreamProvider);
          ref.invalidate(cardsCountProvider);
          ref.invalidate(specificCardsCountProvider);
          break;

        case 'category':
          ref.invalidate(categoriesListStreamProvider);
          ref.invalidate(categoriesCountProvider);
          ref.invalidate(specificCategoriesCountProvider);
          break;

        case 'collection':
          ref.invalidate(collectionsListStreamProvider);
          ref.invalidate(collectionsCountProvider);
          ref.invalidate(collectionsSumProvider);
          ref.invalidate(collectionsRestSumProvider);
          ref.invalidate(specificCollectionsCountProvider);
          ref.invalidate(specificCollectionsSumProvider);
          ref.invalidate(specificCollectionsRestSumProvider);

          ref.invalidate(dayCollectionProvider);
          ref.invalidate(weekCollectionProvider);
          ref.invalidate(monthCollectionProvider);
          ref.invalidate(yearCollectionProvider);

          // ref.refresh(provider)
          break;

        case 'collector':
          ref.invalidate(collectorsListStreamProvider);
          ref.invalidate(collectorsCountProvider);
          ref.invalidate(specificCollectorsCountProvider);
          break;

        case 'customer':
          ref.invalidate(customersListStreamProvider);
          ref.invalidate(customersCountProvider);
          ref.invalidate(specificCustomersCountProvider);
          break;

        case 'economicalActivity':
          ref.invalidate(economicalActivitiesListStreamProvider);
          ref.invalidate(economicalActivitiesCountProvider);
          ref.invalidate(specificEconomicalActivitiesCountProvider);
          break;

        case 'locality':
          ref.invalidate(localitiesListStreamProvider);
          ref.invalidate(localitiesCountProvider);
          ref.invalidate(specificLocalitiesCountProvider);
          break;

        case 'modification':
          //   ref.invalidate(categoriesListStreamProvider);
          //    ref.invalidate(categoriesCountProvider);
          //    ref.invalidate(specificCategoriesCountProvider);
          break;

        case 'personalStatus':
          ref.invalidate(personalStatusListStreamProvider);
          ref.invalidate(personalStatusCountProvider);
          ref.invalidate(specificPersonalStatusCountProvider);
          break;

        case 'product':
          ref.invalidate(productsListStreamProvider);
          ref.invalidate(productsCountProvider);
          ref.invalidate(specificProductsCountProvider);
          break;

        case 'settlement':
          ref.invalidate(settlementsListStreamProvider);
          ref.invalidate(settlementsCountProvider);
          ref.invalidate(specificSettlementsCountProvider);

          ref.invalidate(
              cashOperationsSelectedCardTotalSettlementsNumbersProvider);
          ref.invalidate(cashOperationsSelectedCardSettlementsProvider);
          ref.invalidate(cashOperationsSelectedCardSettlementsCountProvider);
          ref.invalidate(
              cashOperationsSelectedCardSpecificSettlementsCountProvider);

          ref.invalidate(cardSettlementsOverviewProvider);
          ref.invalidate(cardSettlementsOverviewCountProvider);
          ref.invalidate(
              cardSettlementsOverviewSpecificSettlementsCountProvider);
          break;

        case 'stock':
          ref.invalidate(stocksListStreamProvider);
          ref.invalidate(stocksCountProvider);
          ref.invalidate(specificStocksCountProvider);
          break;

        case 'transfer':
          ref.invalidate(transfersListStreamProvider);
          ref.invalidate(transfersCountProvider);
          ref.invalidate(specificTransfersCountProvider);
          break;

        case 'type':
          ref.invalidate(typesListStreamProvider);
          ref.invalidate(typesCountProvider);
          ref.invalidate(specificTypesCountProvider);
          break;

        default:
      }
    } catch (e) {
      debugPrint('Error processing WebSocket message: $e');
    }
  }

  void _onError(error) {
    debugPrint('WebSocket error: $error');
    try {
      _isConnected = false;
      _scheduleReconnect();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _onDone() {
    debugPrint('WebSocket connection closed');
    try {
      _isConnected = false;
      _scheduleReconnect();
    } catch (e) {
      debugPrint(e.toString());
    }
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
