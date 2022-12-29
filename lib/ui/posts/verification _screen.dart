import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/widgets/round_button.dart';

class VeriScreen extends StatefulWidget {
  const VeriScreen({Key? key}) : super(key: key);

  @override
  State<VeriScreen> createState() => _VeriScreenState();
}

class _VeriScreenState extends State<VeriScreen> {
  
  bool loading = false;
 



  //firebase firestore

  final firestore = FirebaseFirestore.instance.collection('Veri').snapshots();
  final _formkey = GlobalKey<FormState>();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
   TextEditingController namecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          automaticallyImplyLeading: false,
          title: Center(
              child: Text(
            'Verification Message',
            style: TextStyle(color: Colors.white),
          )),

        ),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
                TextFormField(
                    controller: namecontroller,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'Enter Owner Name',
                      icon: Icon(Icons.person_outline),
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
                        return 'Enter Correct Owner Name';
                      } else {
                        return null;
                      }
                    },
                  ),
              SizedBox(height: 50,),

                 RoundButton(
                title: 'Upload',
                loading: loading,
                onTap: () async {
                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                  }
                }
                 )
        ]),




      ),
    );
  }
}
