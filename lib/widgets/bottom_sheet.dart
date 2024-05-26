import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_op/function/database_function.dart';
import 'package:crud_op/util/outline_input_border.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  final bool isVal;
  const ContactForm({super.key, required this.isVal});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  Map<String, dynamic>? _documentData;

  List<String> _documentNames = [];

  var group = TextEditingController();
  var name = TextEditingController();
  var phone = TextEditingController();
  var address = TextEditingController();

  String? selectedName;
  @override
  void initState() {
    super.initState();
    _fetchDocumentNames();
  }

  Future<void> _fetchDocumentNames() async {
    final names = await getDocumentNames();
    setState(() {
      _documentNames = names;
    });
  }

  Future<void> _getDocument(String name) async {
    final data = await retrieveDocument(name);
    setState(() {
      _documentData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      margin: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          //padding: const EdgeInsets.all(15),
          children: [
            Text(
              widget.isVal ? 'Add new Contact' : 'Update Value',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            widget.isVal
                ? TextField(
                    controller: name,
                    decoration: inputDecoration(
                      hText: 'Name',
                      //isVal: isVal ? null : 'false',
                      icon: Icons.person,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Choose Name To Update'),
                      DropdownButton(
                        value: selectedName,
                        hint: const Text('Contact Name'),
                        items: _documentNames.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        // const [
                        //   DropdownMenuItem(
                        //     value: 'Bijay',
                        //     child: Text('Bijay'),
                        //   ),
                        //   DropdownMenuItem(
                        //     value: 'Rajesh',
                        //     child: Text('Rajesh'),
                        //   ),
                        //   DropdownMenuItem(
                        //     value: 'Prabin',
                        //     child: Text('Prabin'),
                        //   ),
                        // ]
                        //,
                        onChanged: (value) {
                          //if (selectedName != null) {
                          setState(() {
                            selectedName = value;
                            _getDocument(selectedName!);
                            debugPrint(selectedName);
                          });
                          // }
                        },
                      ),
                    ],
                  ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: group,
              decoration:
                  inputDecoration(hText: 'Group', icon: Icons.group_add),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: phone,
              decoration:
                  inputDecoration(hText: 'Phone', icon: Icons.phone_android),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: address,
              decoration:
                  inputDecoration(hText: 'Address', icon: Icons.location_city),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 100,
              child: ElevatedButton(
                  onPressed: () {
                    widget.isVal
                        ? create(
                            group: group.text.toString(),
                            name: name.text.toString(),
                            phone: phone.text.toString(),
                            address: address.text.toString(),
                          )
                        : update(
                            name: selectedName!,
                            group: group.text.toString(),
                            phone: phone.text.toString(),
                            address: address.text.toString());
                    Navigator.pop(context);
                  },
                  child: Text(widget.isVal ? 'Save' : 'Update')),
            ),
          ],
        ),
      ),
    );
  }
}

Future<dynamic> modelBottomSheet(BuildContext context, bool isVal) {
  return showModalBottomSheet(
    isScrollControlled: true,
    enableDrag: true,
    context: context,
    builder: (context) {
      return ContactForm(isVal: isVal);
    },
  );
}

Future<Map<String, dynamic>?> retrieveDocument(String name) async {
  try {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Phone Book')
        .doc(name)
        .get();
    if (doc.exists) {
      return doc.data() as Map<String, dynamic>?;
    } else {
      debugPrint('Document does not exist');
      return null;
    }
  } catch (e) {
    debugPrint('Error getting document: $e');
    return null;
  }
}

Future<List<String>> getDocumentNames() async {
  try {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Phone Book').get();
    return snapshot.docs.map((doc) => doc.id).toList();
  } catch (e) {
    debugPrint('Error getting document names: $e');
    return [];
  }
}
