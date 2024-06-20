import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/auth/registration/views/widgets/form/form.widget.dart';
import 'package:rst/modules/auth/widgets/logo_side/logo_side.widget.dart';

class RegistrationPage extends ConsumerWidget {
  const RegistrationPage({super.key});

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
