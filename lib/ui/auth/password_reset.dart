import 'package:flutter/material.dart';
import 'package:fyp/ui/auth/signup_firebase.dart';
import 'package:fyp/ui/posts/home_navbar_post_screen.dart';
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
    return Container(
       decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/Select.png'), 
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
      
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.keyboard_arrow_left_sharp, size: 25,color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Column(
              children: [
                Text('Reset Password' , style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),),
                
              ],
            ),
           
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
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: const InputDecoration(
                            
                              hintText: 'Email',
                              icon: Icon(
                                Icons.email_outlined,
                                size: 20,
                                color: Colors.white,
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
      ),
    );
  }
}
