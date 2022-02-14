import 'package:flutter/material.dart';

import '../utils/string.dart';

class SharedDocumentTile extends StatelessWidget {
  String title;
  String expiryDate;
  VoidCallback onTap;

  SharedDocumentTile({
    required this.title,
    required this.expiryDate,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(generateLimitedLengthText(title, 25)),
          subtitle: Text(expiryDate),
          onTap: onTap,
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
