import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oldbike/utils/text_styles.dart';

class NoDataFoundNotice extends StatelessWidget {
  final String? title;
  final String text;
  final double dividerWidth;
  final double textWidth;

  const NoDataFoundNotice({
    Key? key,
    this.title,
    this.text = 'No data were found!\nLogin & start tracking your rides.',
    this.dividerWidth = 100.0,
    this.textWidth = 320.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          const FaIcon(
            FontAwesomeIcons.snowman,
            size: 50.0,
          ),
          SizedBox(
            width: dividerWidth,
            height: 30.0,
            child: const Divider(thickness: 3.0),
          ),
          title == null
              ? Container()
              : SizedBox(
                  height: 50.0,
                  child: Text(
                    title!,
                    style: ktsProfileTitle,
                  ),
                ),
          SizedBox(
            width: textWidth,
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
