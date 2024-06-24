import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/service/websocket/websocket.service.dart';
import 'package:rst/modules/home/views/widgets/home.widget.dart';
import 'package:rst/utils/constants/api/api.constant.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with WidgetsBindingObserver {
  final WebSocketService _webSocketService = WebSocketService();
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _webSocketService.connect();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _webSocketService.disconnect();
    super.dispose();
  }

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
