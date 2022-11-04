import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyp/ui/auth/login_firebase.dart';
import 'package:fyp/utils/utils.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.blueGrey,
          appBar: AppBar(
            title: Text('User Profile Screen'),
            actions: [
              IconButton(
                  onPressed: () {
                    //sign out profile
                    auth.signOut().then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginFirebase()));
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                    });
                  },
                  icon: Icon(Icons.logout_outlined)),
              SizedBox(
                width: 10,
              )
            ],
          ),
          body: Center(
            child: Column(
              children: [
                Stack(children: <Widget>[
                  Container(
                    height: 250,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40)),
                        color: Colors.lightBlue),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 150,
                        width: 150,

                        // ignore: prefer_const_constructors
                        decoration: ShapeDecoration(
                          color: Colors.grey,
                          shape: CircleBorder(),
                        ),

                        child: IconButton(
                          icon: const Icon(Icons.person_add_alt_1_rounded),
                          color: Colors.black,
                          iconSize: 25,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          )),
    );
  }
}
