import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp/screen/layout_screen.dart';
import 'package:fyp/ui/splash_screen.dart';
import 'package:fyp/ui/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBzvlZ3oCfm_JUs2ijmxN4nbGMtwA0FAb8",
            authDomain: "realestateinsignia.firebaseapp.com",
            databaseURL:"https://realestateinsignia-default-rtdb.firebaseio.com",
            projectId: "realestateinsignia",
            storageBucket: "realestateinsignia.appspot.com",
            messagingSenderId: "999701990661",
            appId: "1:999701990661:web:1e67307604fd858e7e3b6c",
            measurementId: "G-R2640F8HH5"));
  }
  else{

      await Firebase.initializeApp();
      runApp(MyApp());
  }

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
