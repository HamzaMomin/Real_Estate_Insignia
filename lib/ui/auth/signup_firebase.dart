import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fyp/ui/auth/mobile_number.dart';
import 'package:fyp/ui/posts/home_navbar_post_screen.dart';
import 'package:fyp/utils/utils.dart';
import 'package:fyp/widgets/round_button.dart';

import 'login_firebase.dart';
import 'package:firebase_database/firebase_database.dart';

class SignUpFirebase extends StatefulWidget {
  const SignUpFirebase({Key? key}) : super(key: key);

  @override
  State<SignUpFirebase> createState() => _SignUpFirebase();
}

class _SignUpFirebase extends State<SignUpFirebase> {
  //loading icon nazar aay ga submit button mai jaab click ho ga
  bool loading = false;
  //form key data save kry ge
  final _formkey = GlobalKey<FormState>();
  //controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  //firebase authunitication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //user ka name is mai aay ga
  final usernameController = TextEditingController();
  //firebase database for table
  final databaseRef = FirebaseDatabase.instance.ref('REI_DATABASE');

  //dispose function
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
  }

  //signup fucntio is called in button jaab press ho ga to submit ho ga
  void signup() {
    // button loading icon display kry ga
    setState(() {
      loading = true;
    });

    //firebase auth with button
    _auth
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NavbarScreen()));
      setState(() {
        loading = true;
      });
      //error aa raha hai to us se bahir aajaay ga us ko catch kr skty hai
    }).onError((error, stackTrace) {
      //from utils class
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }




  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/Select.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Sign Up',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
          ),
          automaticallyImplyLeading: false,
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
                        //  TextFormField(
                        //   keyboardType: TextInputType.text,
                        //   controller: usernameController,
                        //   decoration: const InputDecoration(
                        //       hintText: 'Name',
                        //       icon: Icon(
                        //         Icons.person_outline,
                        //         size: 20,
                        //         color: Colors.white
                        //       )
                        //       ),
                        //        validator: (value){
                        //         if(value!.isEmpty){
                        //         return 'Enter Full Name';
                        //        }
                        //        return null;
                        //        },
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
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
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.text,
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: 'Password',
                              icon: Icon(
                                Icons.password_outlined,
                                size: 20,
                                color: Colors.white,
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter password';
                            }
                            return null;
                          },
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 30,
                ),
                RoundButton(
                  title: 'Sign Up',
                  loading: loading,
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      signup();
                      
                    }

                    

                  },
                ),
                const SizedBox(
                  height: 30,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginFirebase()));
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.purpleAccent,
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),

                SizedBox(
                  height: 20,
                ),

                //   InkWell(
                //     onTap: (){
                //       setState(() {
                //         loading = true;
                //       });
                //        Navigator.push(context,
                //  MaterialPageRoute(builder: (context) => const MobileNumber()));
                //     },
                //     child: Container(

                //         height: 50,
                //         decoration : BoxDecoration(
                //           borderRadius: BorderRadius.circular(20),
                //           border: Border.all(
                //             color: Colors.black,
                //           )
                //         ),

                //         child: Center(

                //           child:  Text('Sign up with number'),
                //         ),
                //     ),
                //   ),
              ]),
        ),
      ),
    );
  }
}
