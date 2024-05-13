// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/widgets/text/text.widget.dart';

class RSTToolTipOption extends ConsumerWidget {
  final IconData icon;
  final Color iconColor;
  final String name;
  final void Function() onTap;
  const RSTToolTipOption({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: 20.0,
        color: iconColor,
      ),
      title: RSTText(
        text: name,
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
