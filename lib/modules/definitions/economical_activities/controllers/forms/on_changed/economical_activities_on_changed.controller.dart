import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/controllers/on_changed/common.on_changed.dart';
import 'package:rst/modules/definitions/economical_activities/providers/economical_activities.provider.dart';

class EconomicalActivityOnChanged {
  static economicalActivityName(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        economicalActivityNameProvider,
      );
}
