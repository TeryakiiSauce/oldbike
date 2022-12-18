///
/// This file aims to mimic a _horizontal scroll_ view.
/// === === === === ===

import 'package:flutter/material.dart';
import 'package:oldbike/components/no_data_found_notice.dart';
import 'package:oldbike/components/show_all_button.dart';

class HorizontalScroll extends StatelessWidget {
  final double height;
  final int itemsCount;
  final List<Widget> child;
  final bool showAllButton;

  /// Mimics a horizontal scroll using the `ListView()` widget.
  const HorizontalScroll({
    Key? key,
    required this.height,
    required this.child,
    this.showAllButton = true,
    this.itemsCount = 1,
  }) : super(key: key);

  Widget displayContent() => Column(
        children: [
          SizedBox(
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
          ),
          showAllButton ? const ShowAllButton() : Container(),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return itemsCount == 0 ? const NoDataFoundNotice() : displayContent();
  }
}
