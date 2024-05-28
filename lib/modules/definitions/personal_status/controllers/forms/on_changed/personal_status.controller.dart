import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/controllers/on_changed/common.on_changed.dart';
import 'package:rst/modules/definitions/personal_status/providers/personal_status.provider.dart';

class PersonalStatusOnChanged {
  static personalStatusName(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        personalStatusNameProvider,
      );
}
