import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/sign_in_screen.dart';

void main() async {
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAEacXG9ML72YUA3TYyqjCXcOm9uyZXWZs",
          appId: "1:145147024586:web:5ed8d064bf60048ed69033",
          messagingSenderId: "145147024586",
          projectId: "flutter-2-a77f4",
          authDomain: "flutter-2-a77f4.firebaseapp.com",)
  );
  runApp(MyApp());
}
/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '동계현장실습',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      home: SignInScreen(),
    );
  }
}*/
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '동계현장실습',
      theme: ThemeData(primarySwatch: Colors.red),
      home: SignInScreen(),
    );
  }
}

