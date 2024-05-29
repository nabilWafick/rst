import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/controllers/on_changed/common.on_changed.dart';
import 'package:rst/modules/definitions/cards/providers/cards.provider.dart';

class CardOnChanged {
  static cardLabel(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        cardLabelProvider,
      );

  static cardTypesNumber(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onIntTextInputValueChanged(
        value,
        ref,
        cardTypesNumberProvider,
      );
}
