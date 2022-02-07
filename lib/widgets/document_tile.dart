import 'package:flutter/material.dart';
import 'package:parichaya_frontend/utils/string.dart';

class DocumentTile extends StatelessWidget {
  final Image image;
  final String title;
  final VoidCallback onTap;
  final Widget? action;

  const DocumentTile({
    required this.title,
    required this.image,
    required this.onTap,
    this.action,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            onTap: onTap,
            contentPadding: const EdgeInsets.fromLTRB(
              15,
              5,
              5,
              5,
            ),
            leading: Container(
                padding: const EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: image,
                )),
            title: Text(generateLimitedLengthText(title, 25)),
            trailing: action
            // subtitle: Text(document.note.length > 25 ?
            //      note.replaceRange(25, null, '...')
            //     : document.note),
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
