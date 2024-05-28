import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/controllers/on_changed/common.on_changed.dart';
import 'package:rst/modules/definitions/collectors/providers/collectors.provider.dart';

class CollectorOnChanged {
  static collectorName(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        collectorNameProvider,
      );

  static collectorFirstnames(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        collectorFirstnamesProvider,
      );

  static collectorPhoneNumber(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        collectorPhoneNumberProvider,
      );

  static collectorAddress(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        collectorAddressProvider,
      );
}
