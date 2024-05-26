import 'package:crud_op/function/database_function.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts List'),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(30),
        child: _streamBuilder(),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>?> _streamBuilder() {
    return StreamBuilder<QuerySnapshot?>(
      stream: FirebaseFirestore.instance.collection('Phone Book').snapshots(),
      builder: (context, contactSnapshot) {
        if (contactSnapshot.data == null) {
          return const Text('No Contact Found !');
        } else if (contactSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final phoneColl = contactSnapshot.data!.docs;

          return ListView.builder(
            itemBuilder: (context, index) {
              return Dismissible(
                onDismissed: (direction) {
                  if (direction == DismissDirection.startToEnd) {
                    delete(name: phoneColl[index].id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 2),
                        content: Text(
                          '${phoneColl[index].id} is Deleted',
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        behavior: SnackBarBehavior.floating,
                        width: 200,
                        elevation: 10,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 2),
                        content: Text(
                          '${phoneColl[index].id} is Deleted',
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        behavior: SnackBarBehavior.floating,
                        width: 200,
                        elevation: 10,
                      ),
                    );
                  }
                },
                key: Key(phoneColl[index].id.toString()),
                background: Container(
                  color: Colors.red,
                  child: const Center(child: Text('Delete')),
                ),
                secondaryBackground: Container(
                  color: Colors.green,
                  child: const Center(child: Text('Update')),
                ),
                child: Card(
                  elevation: 8,
                  child: ListTile(
                    leading: Text(phoneColl[index]['group']),
                    title: Text(phoneColl[index].id),
                    subtitle: Text(phoneColl[index]['phone']),
                    trailing: Text(phoneColl[index]['address']),
                  ),
                ),
              );
            },
            itemCount: phoneColl.length,
          );
        }
      },
    );
  }
}
