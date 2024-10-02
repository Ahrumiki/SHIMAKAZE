import 'package:fireball/models/songs.dart';
import 'package:fireball/service/auth.dart';
import 'package:fireball/service/database.dart';
import 'package:fireball/theme/theme_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// class settingTab extends StatelessWidget {
//   settingTab({super.key});
//   final AuthService _auth = AuthService();
//   bool isSwitched = false;
//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider<Iterable<Song>?>.value(
//         value: DatabaseService(uid: '').ahru,
//         initialData: const <Song>[],
//         child: Scaffold(
//           appBar: AppBar(
//             title: const Text('Setting'),
//           ),
//           body: ListView(padding: const EdgeInsets.all(16), children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Log out',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 IconButton(
//                   onPressed: () async {
//                     await _auth.signOut();
//                   },
//                   icon: const Icon(Icons.logout_outlined),
//                 )
//               ],
//             ),
//             const Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text('Item 2', style: TextStyle(fontSize: 18)),
//                 Switch(
//                   value: isSwitched,
//                   onChanged: (value) {
//                   setState(() {
//                     isSwitched = value;
//                     print("Switch state: $isSwitched");
//                   });
//                   },
//                 ),
//               ],
//             ),
//           ]),

//           //backgroundColor: Colors.brown[50],
//           // body: ListView(
//           //   scrollDirection: Axis.vertical,

//           //   padding: const EdgeInsets.all(16),
//           //   children: [
//           //     ElevatedButton.icon(

//           //         onPressed: () async {
//           //           await _auth.signOut();
//           //         },
//           //         icon: const Icon(Icons.logout_outlined, size: 24),
//           //         label: const Text('Log out', style: TextStyle(fontSize: 16),),
//           //         style: ElevatedButton.styleFrom(
//           //           backgroundColor: Colors.black,
//           //           foregroundColor: Colors.white,
//           //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//           //         ),
//           //     )
//           //   ],
//           // ),
//         ));
//   }
// }

class SettingTab extends StatefulWidget {
  const SettingTab({super.key});

  @override
  _SettingTabState createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  final AuthService _auth = AuthService();
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.themeMode == ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Log out',
                style: TextStyle(fontSize: 18),
              ),
              IconButton(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: const Icon(Icons.logout_outlined),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Dark Mode', style: TextStyle(fontSize: 18)),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  // setState(() {
                  //   _isDarkMode = !_isDarkMode;
                  //   print("Switch state: $isSwitched");
                  // });
                  themeProvider.toggleTheme(value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
