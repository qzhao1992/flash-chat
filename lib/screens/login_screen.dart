import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/componments/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
                onChanged: (value) {       
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your email')),
            SizedBox(
              height: 8.0,
            ),
            TextField(
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password')),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              title: 'Log In',
              colour: Colors.blueAccent,
              onPressed: () async {
                try {
                  _showLoadingDialog();
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);

                  if (user != null) {
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                } catch (e) {
                  Navigator.of(context).pop();
                  print(e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  _showLoadingDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text('L'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        );                                                                                                                                                                                                                                                                                                                                                                                            
      },
    );
  }
}
