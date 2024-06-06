import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/controllers/on_changed/common.on_changed.dart';
import 'package:rst/modules/cash/settlements/providers/settlements.provider.dart';

class SettlementOnChanged {
  static settlementNumber(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onIntTextInputValueChanged(
        value,
        ref,
        settlementNumberProvider,
      );
}
