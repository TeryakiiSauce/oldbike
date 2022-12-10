///
/// This file aims to create an Image with a circle background (either with a border or without).
///
/// Note: This is similar to the `CircularIcon()` widget.
/// === === === === ===

import 'package:flutter/material.dart';
import 'package:oldbike/utils/colors.dart';

class CircularImage extends StatelessWidget {
  final Image image;
  final double size;
  final double padding;

  /// Creates an `Image` with a circular background.
  const CircularImage({
    Key? key,
    required this.image,
    this.size = 10,
    this.padding = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: size * 10,
            minWidth: size * 10,
          ),
          child: FittedBox(
            child: CircleAvatar(
              radius: size * 1.9,
              backgroundColor: kcPrimaryT2,
              child: CircleAvatar(
                backgroundColor: kcPrimary,
                foregroundColor: kcPrimaryT11,
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: image,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
