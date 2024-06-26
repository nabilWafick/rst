import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/models/permission/permission.model.dart';
import 'package:rst/common/widgets/common.widgets.dart';

class PermissionTool extends StatefulHookConsumerWidget {
  final Permission permission;
  final StateProvider<Map<String, bool>> permissionsProvider;
  const PermissionTool({
    super.key,
    required this.permission,
    required this.permissionsProvider,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PermissionToolState();
}

class _PermissionToolState extends ConsumerState<PermissionTool> {
  @override
  void initState() {
    // set default permission
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(widget.permissionsProvider.notifier).update((state) {
        state = {
          ...state,
          widget.permission.back: widget.permission.isGranted,
        };

        return state;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isGranted = useState(widget.permission.isGranted);
    return SizedBox(
      width: 700,
      child: CheckboxListTile(
        value: isGranted.value,
        title: RSTText(
          text: widget.permission.front,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
        onChanged: (value) {
          if (value == true) {
            isGranted.value = true;
            ref.read(widget.permissionsProvider.notifier).update(
                  (state) => state = {
                    ...state,
                    widget.permission.back: true,
                  },
                );
          } else {
            isGranted.value = false;
            ref.read(widget.permissionsProvider.notifier).update(
                  (state) => state = {
                    ...state,
                    widget.permission.back: false,
                  },
                );
          }
        },
      ),
    );
  }
}
