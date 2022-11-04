import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp/ui/posts/posts_screen.dart';

import '../../utils/utils.dart';
import '../../widgets/round_button.dart';

class VerifyCodeScreen extends StatefulWidget {
  //id is screen pr aay ge 
  //final private hota hai 
  final String verificatioID ;
  const VerifyCodeScreen({Key? key , required this.verificatioID}) : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<VerifyCodeScreen> {
 bool loading = false;

  final verifyCode = TextEditingController();
  final auth = FirebaseAuth.instance;
 
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP'),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
              SizedBox(height: 50,),

              TextFormField(
                //keybord numbers wala display ho ga
                keyboardType: TextInputType.number,
                controller: verifyCode,
                decoration: InputDecoration(
                  hintText: '6 Digit code',
                ),
              ),
              SizedBox(height: 30,),

              RoundButton(title:'Verify', loading: loading,
               onTap: ()async{
                setState(() {
                  loading = true;
                });
                final credential = PhoneAuthProvider.credential(
                  //widget . verificationID back screen se aa rehi hai
                  verificationId: widget.verificatioID, 
                  //verifyCode crontroller pr sms aay
                  smsCode: verifyCode.text.toString()
                );

                      //try cache firebase exception hai
                      try{
                        await auth.signInWithCredential(credential);
                                ///jaab auto verifiy ho jaa ga code to next screeen pr lay jaao
                                ///
                     Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen()));

                      }catch(e){
                          setState(() {
                            loading = false;
                          });
                      }
               }
               )
        ]),
      ),


    );
  }
  }
