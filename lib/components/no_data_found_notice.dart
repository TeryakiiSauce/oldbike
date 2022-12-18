import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoDataFoundNotice extends StatelessWidget {
  const NoDataFoundNotice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          SizedBox(
            height: 20.0,
          ),
          FaIcon(
            FontAwesomeIcons.snowman,
            size: 50.0,
          ),
          SizedBox(
            width: 100.0,
            height: 30.0,
            child: Divider(thickness: 3.0),
          ),
          Text(
            'No data were found!\nLogin & start tracking your rides.',
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
