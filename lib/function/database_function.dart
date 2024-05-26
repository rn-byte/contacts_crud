import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

create({
  required String group,
  required String name,
  required String phone,
  required String address,
}) async {
  await FirebaseFirestore.instance.collection('Phone Book').doc(name).set({
    'group': group,
    'phone': phone,
    'address': address,
  });
  debugPrint('Database Created');
}

update({
  required String name,
  required String group,
  required String phone,
  required String address,
}) async {
  await FirebaseFirestore.instance.collection('Phone Book').doc(name).update({
    'group': group,
    'phone': phone,
    'address': address,
  });
  debugPrint('Data Updated');
}

delete({
  required String name,
}) async {
  await FirebaseFirestore.instance.collection('Phone Book').doc(name).delete();
  debugPrint('Data Deleted');
}

// StreamBuilder<QuerySnapshot<Object?>?> _streamBuilder(String Name) {
//   return StreamBuilder<QuerySnapshot?>(
//     stream: FirebaseFirestore.instance.collection('Phone Book').snapshots(),
//     builder: (context, snapshot) {
//       if (snapshot.data == null) {
//         return const Text('No Contact Found !');
//       } else if (snapshot.connectionState == ConnectionState.waiting) {
//         return const Center(child: CircularProgressIndicator());
//       } else {
//         final phoneContact = snapshot.data!.docs;
//         return ListView.builder(
//           itemBuilder: (context, index) {
//             String group = phoneContact[index]['group'].toString();
//             String phone = phoneContact[index]['phone'].toString();
//             String address = phoneContact[index]['address'].toString();
//           },
//           itemCount: phoneContact.length,
//         );
//       }
//     },
//   );
// }


