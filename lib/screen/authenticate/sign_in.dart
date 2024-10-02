import 'package:fireball/service/auth.dart';
import 'package:fireball/shared/app_bar.dart';
import 'package:fireball/shared/constant.dart';
import 'package:fireball/shared/loading.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    return loading
        ? const Loading()
        : Scaffold(
            appBar: BasicAppbar(
              title: SvgPicture.asset('assets/spotify.svg'),
            ),
            // appBar: AppBar(
            //   //backgroundColor: Colors.brown[400],
            //   elevation: 0.0,
            //   title: FittedBox(
            //     fit: BoxFit.cover,
            //     child: Image.asset('assets/promusic.jpg', width: MediaQuery.of(context).size.width, // Chiều rộng bằng với chiều rộng màn hình
            //   height: kToolbarHeight,),

            //     ),
            //   ),
            // actions: <Widget>[
            //   TextButton.icon(
            //       icon: const Icon(Icons.person),
            //       onPressed: () {
            //         widget.toggleView();
            //       },
            //       label: const Text('Resigter'))
            // ],
            body: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 20),
                        const Text(
                          'Sign In',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                            validator: (val) =>
                                val!.isEmpty ? 'Enter an email' : null,
                            onChanged: (val) {
                              email = val;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Enter Email',
                            )
                                .applyDefaults(
                                    Theme.of(context).inputDecorationTheme)
                                .copyWith(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)))
                            // style: const TextStyle(
                            //   color: Colors.blue,
                            //   fontSize: 18,
                            // ),
                            // decoration: textInputDecorate.copyWith(hintText: 'Email'),
                            ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Enter Email',
                          )
                              .applyDefaults(
                                  Theme.of(context).inputDecorationTheme)
                              .copyWith(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30))),
                          validator: (val) => val!.length < 6
                              ? 'Password must be longer than 6 letter!'
                              : null,
                          onChanged: (val) {
                            password = val;
                          },
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 55,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  Colors.green, // Màu nền (background)
                            ),
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result = await _authService
                                    .signInWithEmailAndPassword(
                                        email, password);
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
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          error,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 14),
                        ),
                        Center(
                          
                          child: 
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                              text: "Don't have any account yet?",
                              style: const TextStyle(
                                  color: Colors.green, fontSize: 14),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' Create here!',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Chuyển sang màn hình tạo tài khoản
                                      widget.toggleView();
                                    },
                                ),
                              ],
                            ))
                          
                        )
                      ],
                    ))),
          );
  }
}
