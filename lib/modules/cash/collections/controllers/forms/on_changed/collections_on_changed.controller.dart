import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/controllers/on_changed/common.on_changed.dart';
import 'package:rst/modules/cash/collections/providers/collections.provider.dart';

class CollectionOnChanged {
  static collectionAmount(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        collectionAmountProvider,
      );
}
