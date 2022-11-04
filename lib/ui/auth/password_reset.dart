import 'package:flutter/material.dart';
import 'package:fyp/ui/auth/signup_firebase.dart';
import 'package:fyp/ui/posts/posts_screen.dart';
import 'package:fyp/utils/utils.dart';
import 'package:fyp/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _LoginFirebaseState();
}

class _LoginFirebaseState extends State<ResetPasswordScreen> {
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  //controllers
  final emailController = TextEditingController();

  String email = "";

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //dispose function
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }

  //login function

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Reset Password with firebase'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: const InputDecoration(
                            hintText: 'Email',
                            icon: Icon(
                              Icons.email_outlined,
                              size: 20,
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              RoundButton(
                title: 'Send Request',
                loading: loading,
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    //function call
                    _auth
                        .sendPasswordResetEmail(
                            email: emailController.text.toString())
                        .then((error) {
                      Utils().toastMessage(
                          "Please Check Your Email , a link has been send to you via email"
                              .toString());
                      setState(() {
                        loading = false;
                      });
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                      setState(() {
                        loading = false;
                      });
                    });
                  }
                },
              ),
            ]),
      ),
    );
  }
}
