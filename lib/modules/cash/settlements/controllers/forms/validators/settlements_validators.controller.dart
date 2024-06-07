import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/cash/settlements/providers/settlements.provider.dart';

class SettlementValidors {
  static String? settlementNumber(String? value, WidgetRef ref) {
    final settlementNumber = ref.watch(settlementNumberProvider);
    if (settlementNumber <= 0 || settlementNumber > 372) {
      return 'Entrez un nombre valide';
    }

    return null;
  }

  static String? multipleSettlementsSettlementNumber(
    String? value,
    int settlementIndex,
    WidgetRef ref,
  ) {
    final settlementNumber =
        ref.watch(multipleSettlementsSettlementNumberProvider(settlementIndex));
    if (settlementNumber <= 0 || settlementNumber > 372) {
      return 'Entrez un nombre valide';
    }

    return null;
  }
}
