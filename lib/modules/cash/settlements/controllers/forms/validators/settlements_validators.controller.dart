import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/cash/settlements/providers/settlements.provider.dart';

class SettlementValidors {
  static String? settlementNumber(String? value, WidgetRef ref) {
    final settlementNumber = ref.watch(settlementNumberProvider);
    if (settlementNumber == .0) {
      return 'Entrez un montant valide';
    }
    return null;
  }
}
