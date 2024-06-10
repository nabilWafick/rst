import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/controllers/on_changed/common.on_changed.dart';
import 'package:rst/modules/definitions/types/providers/types.provider.dart';

class TypeOnChanged {
  static typeName(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        typeNameProvider,
      );

  static typeStake(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onDoubleTextInputValueChanged(
        value,
        ref,
        typeStakeProvider,
      );
}
