import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/controllers/on_changed/common.on_changed.dart';
import 'package:rst/modules/auth/registration/providers/registration.provider.dart';

class RegistrationOnChanged {
  static newUserEmail(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        newUserEmailProvider,
      );

  static newUserPassword(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        newUserPasswordProvider,
      );
}
