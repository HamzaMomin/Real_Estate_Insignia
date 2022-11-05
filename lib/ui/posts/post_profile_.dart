import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

   final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(

          body:  //user ke email display ho ge jo auth mai hai firebase
        
             Center(child: Text('Login as: ${FirebaseAuth.instance.currentUser!.email}')),

      ),
    );
  }
}