import 'dart:io';

import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/material.dart';
import 'package:parichaya_frontend/utils/string.dart';

class DocumentTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onTap;
  final Widget? action;

  const DocumentTile({
    required this.title,
    required this.imagePath,
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
                child: imagePath.isEmpty
                    ? FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: 'https://picsum.photos/250?image=9',
                      )
                    : Image.file(
                        File(imagePath),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        semanticLabel: title,
                      ),
                // child: FadeInImage.memoryNetwork(
                //   placeholder: kTransparentImage,
                //   image: imagePath,
                // ),
              ),
            ),
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
