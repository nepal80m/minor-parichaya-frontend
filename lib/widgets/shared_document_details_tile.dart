import 'dart:io';

import 'package:flutter/material.dart';

class SharedDocumentDetailsTile extends StatefulWidget {
  final String title;
  final List images;
  final VoidCallback onTap;

  SharedDocumentDetailsTile({
    required this.title,
    required this.images,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<SharedDocumentDetailsTile> createState() =>
      _SharedDocumentDetailsTileState();
}

class _SharedDocumentDetailsTileState extends State<SharedDocumentDetailsTile> {
  bool isItExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: ExpansionPanelList(
          elevation: 0,
          animationDuration: const Duration(seconds: 1),
          expandedHeaderPadding: const EdgeInsets.all(5),
          expansionCallback: (panelIndex, isExpanded) {
            setState(() {
              isItExpanded = !isExpanded;
            });
          },
          children: [
            ExpansionPanel(
              backgroundColor: Theme.of(context).disabledColor.withOpacity(0.1),
              headerBuilder: (context, isExpanded) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Text(
                    widget.title.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
              body: Container(
                margin: const EdgeInsets.all(10),
                child: GridView.count(
                  padding: EdgeInsets.zero,
                  physics: const ScrollPhysics(),
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: [
                    ...widget.images.map((image) {
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
                                  highlightColor:
                                      Colors.orange.withOpacity(0.1),
                                  splashColor: Colors.black12,
                                  onTap: widget.onTap,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
              canTapOnHeader: true,
              isExpanded: isItExpanded,
            ),
          ],
        ),
      ),
    );
    // return Card(
    //   margin: const EdgeInsets.all(10),
    //   elevation: 0,
    //   color: Theme.of(context).disabledColor.withOpacity(0.1),
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    //   child: Padding(
    //     padding: const EdgeInsets.all(10.0),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           title.toUpperCase(),
    //           style: const TextStyle(
    //             fontSize: 14,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //         const Divider(
    //           height: 20,
    //         ),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         GridView.count(
    //           padding: EdgeInsets.zero,
    //           physics: const ScrollPhysics(),
    //           crossAxisCount: 3,
    //           shrinkWrap: true,
    //           crossAxisSpacing: 15,
    //           mainAxisSpacing: 15,
    //           children: [
    //             ...images.map((image) {
    //               return ClipRRect(
    //                 borderRadius: BorderRadius.circular(15),
    //                 child: Stack(
    //                   children: [
    //                     Positioned.fill(
    //                       child: Image.file(
    //                         File(image.path),
    //                         height: 200,
    //                         width: 200,
    //                         fit: BoxFit.cover,
    //                       ),
    //                     ),
    //                     Positioned.fill(
    //                       child: Material(
    //                         color: Colors.transparent,
    //                         child: InkWell(
    //                           highlightColor: Colors.orange.withOpacity(0.1),
    //                           splashColor: Colors.black12,
    //                           onTap: onTap,
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               );
    //             }).toList(),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
