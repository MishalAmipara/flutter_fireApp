import 'package:fire_app/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn_Page extends StatefulWidget {
  const SignIn_Page({super.key});

  @override
  State<SignIn_Page> createState() => _SignIn_PageState();
}

class _SignIn_PageState extends State<SignIn_Page> {

  var emailAddress=TextEditingController();

  var password=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Card(
                elevation: 5,
                child: TextField(
                  controller: emailAddress,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(

                      prefixIcon: Icon(Icons.email_outlined),
                      label: Text("E-Mail Address"),border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Card(
                elevation: 5,
                child: TextField(
                  controller: password,
                  decoration: InputDecoration(

                      prefixIcon: Icon(Icons.visibility_off),
                      label: Text("Password"),border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: ElevatedButton(onPressed: onPressed, child: Text("Sign In")),
            ),
          ],
        ),
      ),
    );
  }

  void onPressed() {
    signInUser();

  }

  Future<void> signInUser() async {


    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is Registered');


      }
    });

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress.text,
          password: password.text
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      else
        {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return HomePage();
          },));
        }
    }
  }
}
