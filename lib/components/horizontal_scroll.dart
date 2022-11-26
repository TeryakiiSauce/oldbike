///
/// This file aims to mimic a _horizontal scroll_ view.
/// === === === === ===

import 'package:flutter/material.dart';

class HorizontalScroll extends StatelessWidget {
  final double height;
  final int itemsCount;
  final List<Widget> child;

  /// Mimics a horizontal scroll using the `ListView()` widget.
  const HorizontalScroll({
    Key? key,
    required this.height,
    required this.child,
    this.itemsCount = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(
            left: 20.0,
            right: index == itemsCount - 1 ? 20.0 : 0,
          ),
          child: child[index],
        ),
        scrollDirection: Axis.horizontal,
        itemCount: itemsCount,
      ),
    );
  }
}
