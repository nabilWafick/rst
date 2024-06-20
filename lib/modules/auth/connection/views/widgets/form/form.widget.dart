import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/modules/auth/connection/controllers/forms/on_changed/connection_on_changed.controller.dart';
import 'package:rst/modules/auth/connection/controllers/forms/validators/connection_validators.controller.dart';
import 'package:rst/modules/auth/functions/auth.function.dart';
import 'package:rst/routes/routes.dart';

class FormSide extends StatefulHookConsumerWidget {
  const FormSide({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FormSideState();
}

class _FormSideState extends ConsumerState<FormSide> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final enableConnectionButton = useState(true);
    return Container(
      height: screenSize.height,
      width: screenSize.width / 2,
      padding: const EdgeInsets.symmetric(horizontal: 130.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                const RSTTextFormField(
                  label: 'Email',
                  hintText: 'Entrer votre adresse email',
                  isMultilineTextForm: false,
                  obscureText: false,
                  textInputType: TextInputType.emailAddress,
                  validator: ConnectionValidators.userEmail,
                  onChanged: ConnectionOnChanged.userEmail,
                ),
                /*  Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(
                    top: 10.0,
                  ),
                  child: RSTTextButton(
                    text: 'Mot de passe oublié',
                    fontSize: 10.0,
                    fontWeight: FontWeight.w600,
                    onPressed: () {},
                  ),
                ),*/
                const RSTTextFormField(
                  label: 'Mot de passe',
                  hintText: 'Entrer votre mot de passe',
                  isMultilineTextForm: false,
                  obscureText: true,
                  suffixIcon: Icons.visibility_off,
                  textInputType: TextInputType.visiblePassword,
                  validator: ConnectionValidators.userPassword,
                  onChanged: ConnectionOnChanged.userPassword,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                enableConnectionButton.value
                    ? RSTElevatedButton(
                        text: 'Connexion',
                        onPressed: () async {
                          AuthFunctions.connect(
                            context: context,
                            formKey: formKey,
                            ref: ref,
                            enableConnectionButton: enableConnectionButton,
                          );
                        },
                      )
                    : RSTElevatedButton(
                        text: 'Veuillez patienter ...',
                        onPressed: () {},
                      ),
                const SizedBox(
                  height: 25.0,
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 5.0,
                  spacing: 5.0,
                  children: [
                    const RSTText(
                      text: 'Vous n\'avez pas un compte ?',
                      fontSize: 12.0,
                    ),
                    RSTTextButton(
                      onPressed: () {
                        RoutesManager.navigateTo(
                          context: context,
                          routeName: RoutesManager.registration,
                        );
                      },
                      text: 'Inscrivez-vous',
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
