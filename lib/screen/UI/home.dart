
import 'package:fireball/models/songs.dart';

import 'package:fireball/service/auth.dart';
import 'package:fireball/service/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    // void showSettingPanel() {
    //   showModalBottomSheet(
    //       context: context,
    //       builder: (context) {
    //         return const Setting_form();
    //       });
    // }

    return StreamProvider<Iterable<Song>?>.value(
        value: DatabaseService(uid: '').ahru,
        initialData:const <Song>[],
        child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: const Text("FireBase"),
            backgroundColor: Colors.brown[40],
            elevation: 0.0,
            actions: <Widget>[
              TextButton.icon(
                icon: const Icon(Icons.person),
                label: const Text("Log out"),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
              TextButton.icon(
                label: const Text('Settings'),
                icon: const Icon(Icons.settings),
                onPressed: () {},
              )
            ],
          ),
          // body: Container(
          //   decoration: const BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage('assets/coffee_bg.png'),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          //   child: const AhruList(),
          // )
        ));
  }
}
