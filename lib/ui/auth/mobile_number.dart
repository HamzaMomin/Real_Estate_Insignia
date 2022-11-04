import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fyp/ui/auth/verify_code.dart';
import 'package:fyp/utils/utils.dart';
import 'package:fyp/widgets/round_button.dart';

class MobileNumber extends StatefulWidget {
  const MobileNumber({Key? key}) : super(key: key);

  @override
  State<MobileNumber> createState() => _MobileNumberState();
}


class _MobileNumberState extends State<MobileNumber> {

  bool loading = false;
  final phonenumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
   //firebase database for table
  final databaseRef = FirebaseDatabase.instance.ref('Post');
 


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Number login'),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
              SizedBox(height: 50,),

              TextFormField(
                //keybord numbers wala display ho ga
                keyboardType: TextInputType.number,
                controller: phonenumberController,
                decoration: InputDecoration(
                  hintText: 'Insert your phone Number',
                ),
              ),
              SizedBox(height: 30,),

              RoundButton(title:'Sign Up and Login',  loading: loading,
               onTap: (){
                
                  setState(() {
                      loading = true;
                  });
                  
                  auth.verifyPhoneNumber(
                    
                  phoneNumber:  phonenumberController.text.toString(),
                  
                  verificationCompleted: (_){

                    
                      //jaab verifaction ho jaay ge
                      setState(() {
                    loading = true;
                  });
                  }, 
                  //jaab verifaction failed ho jaay ge
                  verificationFailed: (e){
                     setState(() {
                    loading = false;
                  });
                    //execption handling incase of error
                    Utils().toastMessage(e.toString());
                  }, 
                  //verificationId se user ko verify kia jaay ga
                  codeSent: (String verificationID , int? token)
                  {
                    //agr code aa gya to us ko next screen mai send kr do
                      Navigator.push(context,
                     MaterialPageRoute(builder: (context) =>  VerifyCodeScreen(verificatioID: verificationID,)));
                      setState(() {
                    loading = true;
                  });
                  }, 
                  codeAutoRetrievalTimeout: (e){
                     Utils().toastMessage(e.toString());
                  });
                   setState(() {
                    loading = false;
                  });

               })
        ]),
      ),


    );
  }
}