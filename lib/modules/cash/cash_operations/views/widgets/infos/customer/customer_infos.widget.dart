import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/modules/cash/cash_operations/providers/cash_operations.provider.dart';
import 'package:rst/modules/cash/cash_operations/views/widgets/infos/customer/collector_box/collector_box.widget.dart';
import 'package:rst/modules/cash/cash_operations/views/widgets/infos/customer/customer_box/customer_box.widget.dart';
import 'package:rst/utils/colors/colors.util.dart';

class CashOperationsCustomerInfos extends StatefulHookConsumerWidget {
  final double width;
  const CashOperationsCustomerInfos({
    super.key,
    required this.width,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CashOperationsCustomerInfosState();
}

class _CashOperationsCustomerInfosState
    extends ConsumerState<CashOperationsCustomerInfos> {
  @override
  Widget build(BuildContext context) {
    final cashOperationsSelectedCustomer =
        ref.watch(cashOperationsSelectedCustomerProvider);
    final cashOperationsSelectedCustomerCards =
        ref.watch(cashOperationsSelectedCustomerCardsProvider);
    return Container(
      padding: const EdgeInsets.all(
        15.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          15.0,
        ),
        border: Border.all(
          color: RSTColors.sidebarTextColor.withOpacity(.5),
          width: 1.5,
        ),
      ),
      height: 440.0,
      width: widget.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CashOperationsCustomerBox(),
              CashOperationsCollectorBox(),
            ],
          ),
          Wrap(
            runSpacing: 20.0,
            spacing: 20.0,
            alignment: WrapAlignment.spaceBetween,
            runAlignment: WrapAlignment.spaceBetween,
            // runAlignment: WrapAlignment.center,
            //  alignment: WrapAlignment.center,
            //  crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // prof, cni, cat, econ. act, stat. pers, local, unsayf card,

              LabelValue(
                label: 'Profession',
                value: cashOperationsSelectedCustomer != null
                    ? cashOperationsSelectedCustomer.occupation ?? ''
                    : '',
              ),
              LabelValue(
                label: 'CNI/NPI',
                value: cashOperationsSelectedCustomer != null
                    ? cashOperationsSelectedCustomer.nicNumber?.toString() ?? ''
                    : '',
              ),
              LabelValue(
                label: 'Categorie',
                value: cashOperationsSelectedCustomer != null
                    ? cashOperationsSelectedCustomer.category?.name ?? ''
                    : '',
              ),
              LabelValue(
                label: 'Activité Économique',
                value: cashOperationsSelectedCustomer != null
                    ? cashOperationsSelectedCustomer.economicalActivity?.name ??
                        ''
                    : '',
              ),
              LabelValue(
                label: 'St. Personnel',
                value: cashOperationsSelectedCustomer != null
                    ? cashOperationsSelectedCustomer.personalStatus?.name ?? ''
                    : '',
              ),
              LabelValue(
                label: 'Localité',
                value: cashOperationsSelectedCustomer != null
                    ? cashOperationsSelectedCustomer.locality?.name ?? ''
                    : '',
              ),
              LabelValue(
                label: 'Cartes non Satisfaites',
                value: cashOperationsSelectedCustomer != null
                    ? cashOperationsSelectedCustomerCards
                        .where(
                          (card) =>
                              card.repaidAt == null &&
                              card.satisfiedAt == null &&
                              card.transferredAt == null,
                        )
                        .length
                        .toString()
                    : '',
              ),
            ],
          ),
          const SizedBox(),
          /*    Container(
            height: 80.0,
            width: 80.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: RSTColors.sidebarTextColor.withOpacity(.5),
                width: 1.5,
              ),
            ),
            child: Center(
              child: cashOperationsSelectedCustomer != null &&
                      cashOperationsSelectedCustomer.signature != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                      child: Image.asset(
                        cashOperationsSelectedCustomer.signature!,
                      ),
                    )
                  : const Icon(
                      Icons.image,
                      color: RSTColors.primaryColor,
                    ),
            ),
          )
      */
        ],
      ),
    );
  }
}
