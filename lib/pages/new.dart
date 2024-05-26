import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  final bool isVal;

  const ContactForm({super.key, required this.isVal});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController group = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();

  String? selectedName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      margin: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.isVal ? 'Add new Contact' : 'Update Value',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            widget.isVal
                ? TextField(
                    controller: name,
                    decoration: inputDecoration(
                      hText: 'Name',
                      icon: Icons.person,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Choose Name To Update'),
                      DropdownButton<String>(
                        value: selectedName,
                        hint: const Text('Contact Name'),
                        items: const [
                          DropdownMenuItem(
                            value: 'Salim',
                            child: Text('Salim'),
                          ),
                          DropdownMenuItem(
                            value: 'Rajesh',
                            child: Text('Rajesh'),
                          ),
                          DropdownMenuItem(
                            value: 'Prabin',
                            child: Text('Prabin'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedName = value;
                          });
                        },
                      ),
                    ],
                  ),
            const SizedBox(height: 20),
            TextField(
              controller: group,
              decoration:
                  inputDecoration(hText: 'Group', icon: Icons.group_add),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: phone,
              decoration:
                  inputDecoration(hText: 'Phone', icon: Icons.phone_android),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: address,
              decoration:
                  inputDecoration(hText: 'Address', icon: Icons.location_city),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  if (widget.isVal) {
                    create(
                      group: group.text.toString(),
                      name: name.text.toString(),
                      phone: phone.text.toString(),
                      address: address.text.toString(),
                    );
                  } else {
                    update(
                      name: selectedName ?? 'Unknown',
                      field: 'phone',
                      newValue: phone.text.toString(),
                    );
                  }
                  Navigator.pop(context);
                },
                child: Text(widget.isVal ? 'Save' : 'Update'),
              ),
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

InputDecoration inputDecoration(
    {required String hText, required IconData icon}) {
  return InputDecoration(
    hintText: hText,
    prefixIcon: Icon(icon),
    border: const OutlineInputBorder(),
  );
}

Future<void> create({
  required String group,
  required String name,
  required String phone,
  required String address,
}) async {
  // Your create logic here
}

Future<void> update({
  required String name,
  required String field,
  required var newValue,
}) async {
  // Your update logic here
}
