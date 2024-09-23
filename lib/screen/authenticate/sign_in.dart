import 'package:fireball/service/auth.dart';
import 'package:fireball/shared/constant.dart';
import 'package:fireball/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _formkey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Sign In'),
        actions: <Widget>[
          TextButton.icon(
              icon: const Icon(Icons.person),
              onPressed: () {
                widget.toggleView();
              },
              label: const Text('Resigter'))
        ],
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                    ),
                    decoration: textInputDecorate.copyWith(hintText: 'Email'),
                    validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      email = val;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                    ),
                    decoration:
                        textInputDecorate.copyWith(hintText: 'Password'),
                    validator: (val) => val!.length < 6
                        ? 'Password must be longer than 6 letter!'
                        : null,
                    onChanged: (val) {
                      password = val;
                    },
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.pink, // Màu nền (background)
                    ),
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _authService
                            .signInWithEmailAndPassword(email, password);
                        if (result == null) {
                          setState(() {
                            error = 'Account not exist';
                            loading = false;
                          });
                        }
                      }
                    },
                    child: const Text(
                      "Sign in",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  )
                ],
              ))),
    );
  }
}
