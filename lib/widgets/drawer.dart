import 'package:crud_op/pages/contacts.dart';
import 'package:crud_op/pages/login_signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Container drawerSection(BuildContext context) {
  return Container(
    color: const Color.fromARGB(255, 73, 74, 75),
    width: 250,
    child: ListView(children: [
      const Padding(
        padding: EdgeInsets.zero,
        child: DrawerHeader(
            child: Center(
          child: ListTile(
            leading: CircleAvatar(
              //radius: 40,
              child: Icon(Icons.person),
            ),
            title: Text('Peter Griffin',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            subtitle: Text(
              'petergriffin@gmail.com',
              style: TextStyle(fontSize: 11),
            ),
          ),
        )),
      ),
      Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            const ListTile(
              leading: Icon(Icons.home_filled),
              title: Text('Home'),
            ),
            const ListTile(
              leading: Icon(Icons.person_2),
              title: Text('Profile'),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactPage(),
                  )),
              child: const ListTile(
                leading: Icon(Icons.contact_phone),
                title: Text('Contacts'),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Setting'),
            ),
            const ListTile(
              leading: Icon(Icons.share),
              title: Text('Share'),
            ),
            const Divider(
              thickness: 0,
              height: 50,
            ),
            GestureDetector(
              onTap: () async {
                debugPrint('Logout clicked');

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ));
                await FirebaseAuth.instance.signOut();
              },
              child: const ListTile(
                leading: Icon(Icons.logout_rounded),
                title: Text('Logout'),
              ),
            )
          ],
        ),
      ),
    ]),
  );
}
