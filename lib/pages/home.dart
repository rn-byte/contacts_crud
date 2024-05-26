import 'package:crud_op/pages/contacts.dart';
import 'package:crud_op/widgets/bottom_sheet.dart';
import 'package:crud_op/widgets/drawer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          drawer: drawerSection(context),
          appBar: _appBarSection(),
          body: Container(
            margin: const EdgeInsets.only(left: 50, right: 50),
            padding: const EdgeInsets.all(50),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        modelBottomSheet(context, true);
                      },
                      child: const Text('Add contact')),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // update(
                        //     name: 'Salim',
                        //     field: 'phone',
                        //     newValue: '9807966322');
                        modelBottomSheet(context, false);
                      },
                      child: const Text('Update')),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ContactPage(),
                          ),
                        );
                        setState(() {});
                      },
                      child: const Text('Retrive')),
                  const SizedBox(
                    height: 20,
                  ),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       delete(name: 'Sumit');
                  //     },
                  //     child: const Text('Delete')),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          )),
    );
  }

  AppBar _appBarSection() {
    return AppBar(
      title: const Text(
        'Home',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        InkWell(
          onTap: () => const Text('Notification Icon Tapped'),
          child: Container(
            margin: const EdgeInsets.all(20),
            child: const Icon(Icons.notifications_none_rounded),
          ),
        )
      ],
    );
  }
}
