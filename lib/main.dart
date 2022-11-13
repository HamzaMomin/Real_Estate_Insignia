import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp/ui/splash_screen.dart';
import 'package:fyp/ui/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
      await Firebase.initializeApp();
      runApp(MyApp());
    

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Splash(),
    );
  }
}
