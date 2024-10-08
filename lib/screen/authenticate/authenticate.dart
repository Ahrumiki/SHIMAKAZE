import 'package:fireball/screen/authenticate/resigter.dart';
import 'package:fireball/screen/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showSignIn == false) {
      return Resigter(toggleView: toggleView);
    } else {
      return SignIn(toggleView: toggleView);
    }
  }
}
