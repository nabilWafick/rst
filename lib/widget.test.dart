import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/utils/colors/colors.util.dart';

class WidgetTest extends StatefulHookConsumerWidget {
  const WidgetTest({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WidgetTestState();
}

class _WidgetTestState extends ConsumerState<WidgetTest> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    //  final heigth = MediaQuery.of(context).size.height;
    //  final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu,
          size: 40,
          color: RSTColors.primaryColor,
        ),
        title: const RSTText(
          text: 'Voting App',
          fontSize: 25.0,
        ),
        actions: [
          RSTTextButton(
            onPressed: () {},
            text: 'Abomey-Calavi',
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: RSTColors.primaryColor,
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: 8,
              itemBuilder: (context, index) => Card(
                    margin: const EdgeInsets.all(20.0),
                    elevation: 1.0,
                    color: Colors.blueGrey[100],
                    child: SizedBox(
                      height: 300,
                      width: 200,
                      child: Icon(
                        Icons.photo,
                        size: 100,
                        color: RSTColors.primaryColor.withOpacity(.7),
                      ),
                    ),
                  )),
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: RSTColors.primaryColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: 50.0,
        width: MediaQuery.of(context).size.width,
        // color: Colors.blueGrey[400],

        child: const Center(
          child: RSTText(
            text: 'Copyright 2024',
            fontWeight: FontWeight.w500,
            color: RSTColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
