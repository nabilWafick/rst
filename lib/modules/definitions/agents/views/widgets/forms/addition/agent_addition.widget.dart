import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/elevated_button/elevated_button.widget.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/common/widgets/textformfield/textformfield.widget.dart';
import 'package:rst/modules/definitions/agents/controllers/forms/forms.controller.dart';
import 'package:rst/modules/definitions/agents/functions/crud/crud.function.dart';
import 'package:rst/modules/definitions/agents/views/widgets/dialogs/permissions/permissions_dialog.widget.dart';
import 'package:rst/utils/colors/colors.util.dart';

class AgentAdditionForm extends StatefulHookConsumerWidget {
  const AgentAdditionForm({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AgentAdditionFormState();
}

class _AgentAdditionFormState extends ConsumerState<AgentAdditionForm> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final showValidatedButton = useState<bool>(true);
    const formCardWidth = 650.0;
    //  final agentPicture = ref.watch(agentPhotoProvider);
    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const RSTText(
            text: 'Agent',
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close_rounded,
              color: RSTColors.primaryColor,
              size: 30.0,
            ),
          ),
        ],
      ),
      content: Container(
        // color: Colors.blueGrey,
        padding: const EdgeInsets.all(10.0),
        width: formCardWidth,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /*/     Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 25.0,
                        horizontal: 55.0,
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 15.0),
                      //width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: RSTColors.sidebarTextColor,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                        shape: BoxShape.rectangle,
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: () async {
                            final imageFromGallery =
                                await FunctionsController.pickFile();
                            ref.read(agentPhotoProvider.notifier).state =
                                imageFromGallery;
                          },
                          child: agentPicture == null
                              ? const Icon(
                                  Icons.photo,
                                  size: 150.0,
                                  color: RSTColors.primaryColor,
                                )
                              : Image.asset(
                                  agentPicture,
                                  height: 250.0,
                                  width: 250.0,
                                ),
                        ),
                      ),
                    ),
                    const RSTText(
                      text: 'Agent',
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
          */
              Wrap(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    width: formCardWidth / 2.3,
                    child: const RSTTextFormField(
                      label: 'Nom',
                      hintText: 'Nom',
                      isMultilineTextForm: false,
                      obscureText: false,
                      textInputType: TextInputType.name,
                      validator: AgentValidators.agentName,
                      onChanged: AgentOnChanged.agentName,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    width: formCardWidth / 2.3,
                    child: const RSTTextFormField(
                      label: 'Prénoms',
                      hintText: 'Prénoms',
                      isMultilineTextForm: false,
                      obscureText: false,
                      textInputType: TextInputType.name,
                      validator: AgentValidators.agentFirstnames,
                      onChanged: AgentOnChanged.agentFirstnames,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    width: formCardWidth / 2.3,
                    child: const RSTTextFormField(
                      label: 'Téléphone',
                      hintText: '+229|00229XXXXXXXX',
                      isMultilineTextForm: false,
                      obscureText: false,
                      textInputType: TextInputType.name,
                      validator: AgentValidators.agentPhoneNumber,
                      onChanged: AgentOnChanged.agentPhoneNumber,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    width: formCardWidth / 2.3,
                    child: const RSTTextFormField(
                      label: 'Email',
                      hintText: 'test@gmail.com',
                      isMultilineTextForm: false,
                      obscureText: false,
                      textInputType: TextInputType.emailAddress,
                      validator: AgentValidators.agentEmail,
                      onChanged: AgentOnChanged.agentEmail,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    width: formCardWidth / 2.3,
                    child: const RSTTextFormField(
                      label: 'Adresse',
                      hintText: 'Adresse',
                      isMultilineTextForm: false,
                      obscureText: false,
                      textInputType: TextInputType.name,
                      validator: AgentValidators.agentAddress,
                      onChanged: AgentOnChanged.agentAddress,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 10.0,
                    ),
                    width: formCardWidth / 2.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        color: RSTColors.tertiaryColor,
                        width: .5,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const AgentPermissionsDialog(),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 17.0,
                        ),
                        child: RSTText(
                          text: 'Permissions',
                          fontSize: 10.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 170.0,
              child: RSTElevatedButton(
                text: 'Fermer',
                backgroundColor: RSTColors.sidebarTextColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            showValidatedButton.value
                ? SizedBox(
                    width: 170.0,
                    child: RSTElevatedButton(
                      text: 'Valider',
                      onPressed: () async {
                        try {
                          await AgentsCRUDFunctions.create(
                            context: context,
                            formKey: formKey,
                            ref: ref,
                            showValidatedButton: showValidatedButton,
                          );
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      },
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ],
    );
  }
}
