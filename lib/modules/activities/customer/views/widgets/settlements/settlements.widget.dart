import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rst/modules/activities/customer/views/widgets/settlements/body/body.widget.dart';
import 'package:rst/modules/activities/customer/views/widgets/settlements/footer/footer.widget.dart';

class CustomerActivitiesSettlements extends StatefulHookConsumerWidget {
  const CustomerActivitiesSettlements({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomerActivitiesSettlementsState();
}

class _CustomerActivitiesSettlementsState
    extends ConsumerState<CustomerActivitiesSettlements> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        //height: 350.0,
        margin: const EdgeInsets.only(top: 30.0),
        child: const Column(
          children: [
            CustomerActivitiesSettlementsCardBody(),
            CustomerActivitiesSettlementsCardFooter(),
          ],
        ),
      ),
    );
  }
}
