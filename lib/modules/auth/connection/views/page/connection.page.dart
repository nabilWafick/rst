import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/auth/connection/views/widgets/form/form.widget.dart';
import 'package:rst/modules/auth/widgets/logo_side/logo_side.widget.dart';

class ConnectionPage extends ConsumerWidget {
  const ConnectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Row(
        children: [
          LogoSide(),
          FormSide(),
        ],
      ),
    );
  }
}
