import 'package:fire_app/SignIn_Page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MaterialApp(
    home: RegisterPage(),
  ));
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var emailAddress=TextEditingController();

  var password=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
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
              child: ElevatedButton(onPressed: onPressed, child: Text("Register")),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onPressed() async {
    await FirebaseAuth.instance.signOut();
    registerUser();

    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is Registered');


      }
    });
  }

  Future<void> registerUser() async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress.text,
        password: password.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return SignIn_Page();
        },));
      }
      else{
        print("Logged In Successfully");
      }
    } catch (e) {
      print(e);
    }
  }
}
