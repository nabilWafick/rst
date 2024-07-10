import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/modules/home/views/widgets/home.widget.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  // late WebSocketService _webSocketService;

  @override
  void initState() {
    super.initState();

    // instanciate webSocketService
    // _webSocketService = WebSocketService(ref: ref);

    //  WidgetsBinding.instance.addObserver(this);

    // try connection
    // _webSocketService.connect();
  }

  /*
  Future<void> _connectWebSocket() async {
    try {
      await _webSocketService.connect();
    } catch (e) {
      debugPrint('Failed to connect to WebSocket: $e');
    }
  }*/

/*
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint('App lifecycle state changed to: $state');
    if (state == AppLifecycleState.resumed) {
      _webSocketService.connect();
    } else if (state == AppLifecycleState.paused) {
      _webSocketService.disconnect();
    }
  }
*/

/*
  @override
  void dispose() {
    debugPrint('HomePage dispose called');
    WidgetsBinding.instance.removeObserver(this);
    _webSocketService.disconnect();
    super.dispose();
  }
*/
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          Sidebar(),
          Main(),
        ],
      ),
    );
  }
}
