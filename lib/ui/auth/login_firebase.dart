import 'package:flutter/material.dart';
import 'package:fyp/ui/auth/signup_firebase.dart';
import 'package:fyp/ui/posts/home_navbar_post_screen.dart';
import 'package:fyp/utils/utils.dart';
import 'package:fyp/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'password_reset.dart';
class LoginFirebase extends StatefulWidget {
  const LoginFirebase({Key? key}) : super(key: key);

  @override
  State<LoginFirebase> createState() => _LoginFirebaseState();
}

class _LoginFirebaseState extends State<LoginFirebase> {
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  //controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
   

  //dispose function
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  //login function
  void login()
  {     
    // loading jaab true ho ga taab button mai circle aay ga
       setState(() {
         loading = true;
       });
      _auth.signInWithEmailAndPassword(
        email: emailController.text.toString(),
         password: passwordController.text.toString()).then((value){

            //display kry ga kon sa user login hai
            Utils().toastMessage(value.user!.email.toString());
             
             Navigator.push(
          context, MaterialPageRoute(builder: (context) => const NavbarScreen()
          )
          );
          setState(() {
         loading = false;
       });
            //agr error aa jaay
        }).onError((error, stackTrace){
          debugPrint(error.toString());
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
            image: AssetImage('assets/Login.png'), 
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
          
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('Login' , style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),),
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
                              )
                              ),
                               validator: (value){
                                if(value!.isEmpty){
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
                              )
                              ),
                               validator: (value){
                                if(value!.isEmpty){
                                return 'Enter password';
                               }
                               return null;
                               },
                        ),
                      ],
                    )),
                

                    SizedBox(height: 15),

                          Row(  
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                            TextButton(onPressed: (){
                                   Navigator.push(
                 context, MaterialPageRoute(builder: (context) => const ResetPasswordScreen()
               )
                    );
                            }, child: Text('Forgot Password ' , style: TextStyle(color: Colors.purpleAccent
                    ),))
                          ],),


                RoundButton(
                  title: 'Login',
                  loading: loading,
                  onTap: () {
                    if(_formkey.currentState!.validate()) {

                        //function call
                        login();
                    }
                  },
                ),
                const SizedBox(height: 10,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Dont have an account?'),
                    TextButton(onPressed: (){
                        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const SignUpFirebase()
            )
            );
                    }, child: Text('Sign Up', style: TextStyle(color: Colors.purpleAccent
                    ),
                    ),
                    )
                  ],
                ),
                          
              ]),
        ),
      ),
    );
  }
}
