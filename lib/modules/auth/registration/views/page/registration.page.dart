import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/modules/auth/registration/views/widgets/form/form.widget.dart';
import 'package:rst/modules/auth/widgets/logo_side/logo_side.widget.dart';

class RegistrationPage extends StatefulHookConsumerWidget {
  const RegistrationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegistrationPageState();
}

class _RegistrationPageState extends ConsumerState<RegistrationPage> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          LogoSide(),
          FormSide(
              //   formKey: formKey,
              ),
          /*  SecurityQuestionsSide(
            formKey: formKey,
          )*/
        ],
      ),
    );
  }
}
