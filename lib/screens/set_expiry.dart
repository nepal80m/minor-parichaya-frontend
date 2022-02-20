import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:parichaya_frontend/models/document_model.dart';
import 'package:provider/provider.dart';
import 'share_details.dart';

import '../providers/share_links.dart';
import '../widgets/ui/appbar_confirmation_button.dart';

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
          .format(DateTime.now().add(const Duration(days: 1))));
  var _isloading = false;

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
        ModalRoute.of(context)?.settings.arguments as List<Document>;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).primaryColor),
        title: const Text('SET EXTRA INFO'),
        actions: [
          DoneButton(
            text: 'Done',
            icon: const Icon(Icons.done),
            onPressed: () async {
              if (titleController.text.isEmpty) {
                final snackBar = SnackBar(
                    backgroundColor: Theme.of(context).errorColor,
                    content: const Text('Title is required.'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                // Provider.of<ShareLinks>(context, listen: false).syncToDB();
                setState(() {
                  _isloading = true;
                });
                final Connectivity _connectivity = Connectivity();
                ConnectivityResult connectivityResult =
                    await _connectivity.checkConnectivity();

                if (connectivityResult == ConnectivityResult.none) {
                  final snackBar = SnackBar(
                      backgroundColor: Theme.of(context).errorColor,
                      content: const Text(
                          'You are currently offline. Please connect to your internet to create new share link.'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  setState(() {
                    _isloading = false;
                  });
                  return;
                }
                final newId =
                    await Provider.of<ShareLinks>(context, listen: false)
                        .addShareLink(
                  title: titleController.text,
                  expiryDate: dateController.text,
                  documents: selectedDocuments,
                );
                setState(() {
                  _isloading = false;
                });
                Navigator.of(context)
                  ..pop()
                  ..pop();
                Navigator.of(context)
                    .pushNamed(ShareDetails.routeName, arguments: newId);
              }
            },
          )
        ],
      ),
      body: _isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : LayoutBuilder(
              builder: (ctx, constraints) {
                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
