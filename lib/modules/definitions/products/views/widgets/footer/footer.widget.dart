import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/widgets/common.widgets.dart';

class ProductsPageFooter extends ConsumerWidget {
  const ProductsPageFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: .0,
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              RSTText(
                text: 'Total: ',
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
              RSTText(
                text: '100 produits',
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 20.0,
                  color: Colors.grey.shade700,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                ),
                child: const RSTText(
                  text: '1',
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20.0,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          const Row(
            children: [
              RSTText(
                text: '1',
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
              RSTText(
                text: ' - ',
                fontSize: 10.0,
                fontWeight: FontWeight.w400,
              ),
              RSTText(
                text: '50',
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
              RSTText(
                text: ' sur ',
                fontSize: 10.0,
                fontWeight: FontWeight.w500,
              ),
              RSTText(
                text: '100',
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
