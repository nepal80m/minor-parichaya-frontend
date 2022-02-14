import 'package:flutter/material.dart';

import '../utils/string.dart';

class SharedDocumentTile extends StatelessWidget {
  String title;
  String expiryDate;

  SharedDocumentTile({
    required this.title,
    required this.expiryDate,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(generateLimitedLengthText(title, 25)),
          subtitle: Text(expiryDate),
        ),
        const Divider(
          indent: 10,
          endIndent: 10,
          height: 1,
        )
      ],
    );
  }
}
