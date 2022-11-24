import 'package:flutter/material.dart';

class HorizontalScroll extends StatelessWidget {
  final double height;
  final int itemsCount;
  final Widget child;

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
          child: child,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: itemsCount,
      ),
    );
  }
}
