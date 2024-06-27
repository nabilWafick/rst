import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/widgets/tooltip/tooltip_option/tooltip_option.model.dart';
import 'package:rst/utils/colors/colors.util.dart';

class RSTTooltip extends StatefulHookConsumerWidget {
  final Widget? child;
  final List<RSTToolTipOption?> options;
  const RSTTooltip({
    super.key,
    this.child,
    required this.options,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RSTTooltipState();
}

class _RSTTooltipState extends ConsumerState<RSTTooltip> {
  final focusNode = FocusNode();
  final layerLink = LayerLink();

  OverlayEntry? entry;

  void showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final targetSize = renderBox.size;
    final targetPosition = renderBox.localToGlobal(Offset.zero);
    final screenSize = MediaQuery.of(context).size;

    const overlayHeight =
        200.0; // Adjust this according to your overlay's height
    const overlayWidth = 200.0; // Adjust this according to your overlay's width

    final overlayPosition = targetPosition.dy + targetSize.height + 3;

    final isOverlayBelow = screenSize.height - overlayPosition > overlayHeight;

    entry = OverlayEntry(
      maintainState: false,
      builder: (context) => Positioned(
        /*  top: isOverlayBelow
            ? overlayPosition
            : targetPosition.dy - overlayHeight,
        left: targetPosition.dx,*/
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            hideOverlay();
          },
          child: CompositedTransformFollower(
            link: layerLink,
            showWhenUnlinked: false,
            offset: Offset(
              -100,
              isOverlayBelow ? targetSize.height : -200,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  elevation: 5.0,
                  color: RSTColors.backgroundColor,
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    width: overlayWidth,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              hideOverlay();
                            },
                            child: const Icon(
                              Icons.close,
                              color: RSTColors.primaryColor,
                              size: 25.0,
                            ),
                          ),
                        ),
                        // this is done so as to perform onTap function
                        ...widget.options.map(
                          (option) => option != null
                              ? RSTToolTipOption(
                                  icon: option.icon,
                                  iconColor: option.iconColor,
                                  name: option.name,
                                  onTap: () {
                                    option.onTap();
                                    hideOverlay();
                                  },
                                )
                              : const SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry!);
  }

  void hideOverlay() {
    entry?.remove();
    entry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CompositedTransformTarget(
          link: layerLink,
          child: InkWell(
            onTap: () {
              if (entry != null) {
                hideOverlay();
              } else {
                showOverlay();
              }
            },
            child: widget.child ??
                const Icon(
                  Icons.more_vert,
                  color: RSTColors.primaryColor,
                ),
          ),
        ),
      ],
    );
  }
}
