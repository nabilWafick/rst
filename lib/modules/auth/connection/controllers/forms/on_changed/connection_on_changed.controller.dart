import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/controllers/on_changed/common.on_changed.dart';
import 'package:rst/modules/auth/connection/providers/connection.provider.dart';

class ConnectionOnChanged {
  static userEmail(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        userEmailProvider,
      );

  static userPassword(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        userPasswordProvider,
      );
}
