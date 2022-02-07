import 'package:flutter/material.dart';

class DisplayItems extends StatelessWidget {
  final String title;
  final String note;
  final List<Image> images;
  final double maxheight;

  const DisplayItems(this.title, this.note, this.images, this.maxheight,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline3,
        ),
        const SizedBox(
          height: 10,
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     for (var i in tags)
        //       Padding(
        //         padding: const EdgeInsets.only(right: 5),
        //         child: Container(
        //           height: 25,
        //           padding: const EdgeInsets.all(5),
        //           margin: const EdgeInsets.all(5),
        //           decoration: BoxDecoration(
        //             color: Theme.of(context).colorScheme.primary,
        //             borderRadius: BorderRadius.circular(10),
        //           ),
        //           child: Text(
        //             i,
        //             style: Theme.of(context).textTheme.caption,
        //           ),
        //         ),
        //       ),
        //   ],
        // ),
        const SizedBox(
          height: 10,
        ),
        Text(
          note,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(
          height: 10,
        ),
        for (var i in images)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: maxheight * 0.3,
              child: i,
            ),
          ),
      ],
    );
  }
}
