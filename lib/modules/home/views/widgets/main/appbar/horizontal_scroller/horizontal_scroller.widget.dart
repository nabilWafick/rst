import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/utils/colors/colors.util.dart';

class AppBarHorizontalScroller extends StatefulHookConsumerWidget {
  final List<Widget> children;

  const AppBarHorizontalScroller({super.key, required this.children});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AppBarHorizontalScrollerState();
}

class _AppBarHorizontalScrollerState
    extends ConsumerState<AppBarHorizontalScroller> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(
            horizontal: 55.0,
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            children: widget.children,
          ),
        ),
        Positioned(
          left: 0,
          child: InkWell(
            onTap: () {
              _scrollController.animateTo(
                _scrollController.offset -
                    MediaQuery.of(context).size.width / 5,
                curve: Curves.linear,
                duration: const Duration(milliseconds: 100),
              );
            },
            child: Card(
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: RSTColors.backgroundColor,
              //  color: RSTColors.primaryColor,
              shadowColor: Colors.white,
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  //  color: Colors.white,
                  color: RSTColors.primaryColor,
                  size: 20.0,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: InkWell(
            onTap: () {
              _scrollController.animateTo(
                _scrollController.offset +
                    MediaQuery.of(context).size.width / 5,
                curve: Curves.linear,
                duration: const Duration(milliseconds: 100),
              );
            },
            child: Card(
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: RSTColors.backgroundColor,
              // color: RSTColors.primaryColor,
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  //  color: Colors.white,
                  color: RSTColors.primaryColor,
                  size: 20.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
