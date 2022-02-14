import 'dart:io';

import 'package:flutter/material.dart';

class SharedDocumentDetailsTile extends StatelessWidget {
  String title;
  List images;
  VoidCallback onTap;

  SharedDocumentDetailsTile({
    required this.title,
    required this.images,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 0,
      color: Theme.of(context).disabledColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(
              height: 20,
            ),
            const SizedBox(
              height: 10,
            ),
            GridView.count(
              padding: EdgeInsets.zero,
              physics: const ScrollPhysics(),
              crossAxisCount: 3,
              shrinkWrap: true,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: [
                ...images.map((image) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.file(
                            File(image.path),
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              highlightColor: Colors.orange.withOpacity(0.1),
                              splashColor: Colors.black12,
                              onTap: onTap,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
