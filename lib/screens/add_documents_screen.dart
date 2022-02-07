import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddDocuments extends StatelessWidget {
  const AddDocuments({Key? key}) : super(key: key);
  static const routeName = '/add_documents';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).primaryColor),
        title: const Text(
          'ADD NEW DOCUMENT',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: LayoutBuilder(builder: (ctx, constraints) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TITLE',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  onChanged: (value) {
                    return;
                  },
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.grey,
                      border: InputBorder.none),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'NOTE',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  onChanged: (value) {
                    return;
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.grey,
                    border: InputBorder.none,
                  ),
                  maxLines: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'IMAGE',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueAccent,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_box_outlined,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
