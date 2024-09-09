import 'package:fireball/models/user.dart';
import 'package:fireball/screen/UI/home_song.dart';
import 'package:fireball/screen/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   final user = Provider.of<Users>(context);
  //   // ignore: unnecessary_null_comparison
  //   if (user == null) {
  //     return const Authenticate();
  //   } else {
  //     return Home();
  //   }
  // }
  @override
  Widget build(BuildContext context) {
  final user = Provider.of<Users?>(context); // Users? cho phép null
  
  if (user == null) {
    return const Authenticate(); // Nếu user là null, hiển thị trang đăng nhập
  } else {
    return const MusicApp(); // Nếu user không null, hiển thị trang chính
  }
}

}
