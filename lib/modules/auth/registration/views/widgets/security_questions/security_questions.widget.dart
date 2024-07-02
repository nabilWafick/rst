import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/models/rounded_style/rounded_style.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/family_textformfield/family_textformfield.widget.dart';
import 'package:rst/common/widgets/family_textformfield/on_changed/family_form_field_on_changed.dart';
import 'package:rst/common/widgets/family_textformfield/validator/family_form_field_validator.dart';
import 'package:rst/modules/auth/registration/providers/registration.provider.dart';

class SecurityQuestionsSide extends StatefulHookConsumerWidget {
  final GlobalKey<FormState> formKey;
  const SecurityQuestionsSide({
    super.key,
    required this.formKey,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SecurityQuestionsSideState();
}

class _SecurityQuestionsSideState extends ConsumerState<SecurityQuestionsSide> {
  String? securityQuestionResponseChecker({required dynamic value}) {
    if (value.isEmpty) {
      return 'Entrez une réponse';
    }
    if (value.length < 4) {
      return 'Réponse trop courte';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final securityQuestions = ref.watch(securityQuestionsProvider);
    return Container(
      padding: const EdgeInsetsDirectional.all(10.0),
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const RSTText(
              text: 'Questions de Sécurité',
              fontSize: 25.0,
              fontWeight: FontWeight.w500,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RSTStringDropdown(
                  label: 'Question1',
                  providerName: 'securityQuestion1',
                  dropdownMenuEntriesLabels: securityQuestions,
                  dropdownMenuEntriesValues: securityQuestions,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: 300.0,
                  child: FamilyTextFormField(
                    inputName: 'securityQuestion1',
                    textInputType: TextInputType.text,
                    roundedStyle: RoundedStyle.full,
                    valueChecker: securityQuestionResponseChecker,
                    validator: FamilyFormFieldValidator.textFieldValue,
                    onChanged: FamilyFormFieldOnChanged.textFieldValue,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
