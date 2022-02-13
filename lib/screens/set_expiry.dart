import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'share_details.dart';

import '../providers/share_links.dart';
import '../widgets/ui/done_botton.dart';

class SetExpiry extends StatefulWidget {
  const SetExpiry({Key? key}) : super(key: key);

  static const routeName = '/set_expiry';

  @override
  State<SetExpiry> createState() => _SetExpiryState();
}

class _SetExpiryState extends State<SetExpiry> {
  final titleController = TextEditingController();
  final messageController = TextEditingController();
  final dateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd')
          .format(DateTime.now().add(Duration(days: 1))));

  void _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(
        const Duration(days: 7),
      ),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        dateController.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedDocuments =
        ModalRoute.of(context)?.settings.arguments as List;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).primaryColor),
        title: const Text('SET EXTRA INFO'),
        actions: [
          DoneButton(onPressed: () {
            Provider.of<ShareLinks>(context, listen: false)
                .addShareLinks(selectedDocuments, dateController.text);
            Navigator.of(context)
              ..pop()
              ..pop();
            Navigator.of(context).pushNamed(ShareDetails.routeName,
                arguments: titleController.text);
          })
        ],
      ),
      body: LayoutBuilder(
        builder: (ctx, constraints) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Text(
                      'Title',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  TextField(
                    controller: titleController,
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromRGBO(220, 220, 220, 0.6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  // const Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  //   child: Text(
                  //     'Message',
                  //     style: TextStyle(fontSize: 18),
                  //   ),
                  // ),
                  // TextField(
                  //   controller: messageController,
                  //   textInputAction: TextInputAction.next,
                  //   maxLines: 6,
                  //   decoration: InputDecoration(
                  //     filled: true,
                  //     fillColor: const Color.fromRGBO(220, 220, 220, 0.6),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //       borderSide: BorderSide.none,
                  //     ),
                  //   ),
                  //   onChanged: (value) {
                  //     return;
                  //   },
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Text(
                      'Set Expiry Date',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  TextField(
                    controller: dateController,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.calendar_today_outlined),
                      filled: true,
                      fillColor: const Color.fromRGBO(220, 220, 220, 0.6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    readOnly: true,
                    onTap: _showDatePicker,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
