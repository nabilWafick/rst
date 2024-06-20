import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/widgets/logo/logo.dart';
import 'package:rst/utils/colors/colors.util.dart';

class LogoSide extends ConsumerWidget {
  const LogoSide({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 130.0),
        height: screenSize.height,
        width: screenSize.width / 2,
        color: RSTColors.primaryColor,
        child: const RSTLogo(
          fontSize: 40.0,
          fontWeight: FontWeight.w900,
          color: RSTColors.backgroundColor,
        ));
  }
}
