import 'package:diabeta_app/components/constants.dart';
import 'package:diabeta_app/screens/auth_screen.dart';
import 'package:diabeta_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
      
  @override
  Widget build(BuildContext context) {
    var _currentUser = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: kPrimaryColor,
      ),
      home: _currentUser != null ? const AuthScreen() : const LoginScreen(),
    );
  }
}
