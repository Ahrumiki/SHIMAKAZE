// import 'package:fireball/models/user.dart';
// import 'package:fireball/service/database.dart';
// import 'package:fireball/shared/constant.dart';
// import 'package:fireball/shared/loading.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class Setting_form extends StatefulWidget {
//   const Setting_form({super.key});

//   @override
//   State<Setting_form> createState() => _Setting_formState();
// }

// class _Setting_formState extends State<Setting_form> {
//   final _formKey = GlobalKey<FormState>();
//   final List<String> sugars = ['0', '1', '2', '3', '4'];

//   String? _currentName;
//   String? _currentSugars;
//   int? _currentStrength;
//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<Users>(context);
//     return StreamBuilder<UserData>(
//         stream: DatabaseService(uid: user.uid).userData,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             UserData? userData = snapshot.data;
//             return Form(
//               key: _formKey,
//               child: Column(
//                 children: <Widget>[
//                   const Text(
//                     'Update Infor',
//                     style: TextStyle(fontSize: 28),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   TextFormField(
//                       initialValue: userData!.name,
//                       decoration: textInputDecorate,
//                       validator: (val) =>
//                           val!.isEmpty ? 'Enter the name' : null,
//                       onChanged: (val) {
//                         setState(() {
//                           _currentName = val;
//                         });
//                       }),
//                   const SizedBox(height: 20),
//                   DropdownButtonFormField(
//                     decoration: textInputDecorate,
//                     value: _currentSugars ?? userData.sugars,
//                     items: sugars.map((sugar) {
//                       return DropdownMenuItem(
//                         value: sugar,
//                         child: Text('$sugar sugar'),
//                       );
//                     }).toList(),
//                     onChanged: (val) {
//                       setState(() {
//                         _currentSugars = val!;
//                       });
//                     },
//                   ),
//                   Slider(
//                       value: (_currentStrength ?? userData.strength).toDouble(),
//                       min: 100.0,
//                       max: 900.0,
//                       divisions: 8,
//                       activeColor: Colors.brown[_currentStrength ?? 100],
//                       onChanged: (val) {
//                         setState(() {
//                           _currentStrength = val.toInt();
//                         });
//                       }),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () async {
//                       if (_formKey.currentState!.validate()) {
//                         await DatabaseService(uid: user.uid).updateUserData(
//                             _currentSugars ?? userData.sugars,
//                             _currentName ?? userData.name,
//                             _currentStrength ?? userData.strength);
//                         if (mounted) {
//                           // mounted kiểm tra xem Widget có còn trong cây không
//                           Navigator.pop(context);
//                         }
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                     ),
//                     child: const Text(
//                       'Update',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             return const Loading();
//           }
//         });
//   }
// }
