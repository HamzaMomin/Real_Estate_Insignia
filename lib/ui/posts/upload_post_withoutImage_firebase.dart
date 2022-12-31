import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/ui/posts/upload_posts_firebase.dart';

import '../../utils/utils.dart';
import '../../widgets/round_button.dart';

class Form_No_image extends StatefulWidget {
  const Form_No_image({Key? key}) : super(key: key);

  @override
  State<Form_No_image> createState() => _Form_No_imageState();
}

final postRef = FirebaseDatabase.instance.ref().child('UserApplication');

DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Post');

//firebase firestore

final firestore = FirebaseFirestore.instance.collection('Property');

final FirebaseAuth auth = FirebaseAuth.instance;
final user = FirebaseAuth.instance.currentUser;

bool loading = false;

final _formkey = GlobalKey<FormState>();
TextEditingController namecontroller = TextEditingController();
TextEditingController cniccontroller = TextEditingController();
TextEditingController mobilecontroller = TextEditingController();





const List<String> list = <String>['Sale', 'Rent'];
String dropdownValue = list.first;


class _Form_No_imageState extends State<Form_No_image> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UploadScreen()));
                },
              )
            ],
            automaticallyImplyLeading: false,
            title: Center(
                child: Text(
              'Property List Form Step : 1',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            )),
          ),
          body: Padding(
            padding: EdgeInsets.all(25.0),
            child: Center(
              child: Form(
                key: _formkey,
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    controller: namecontroller,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'Enter Owner Name',
                      icon: Icon(Icons.person_outline),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[a-z A-Z]+$'))
                    ],
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                        return 'Enter Correct Owner Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: mobilecontroller,
                    keyboardType: TextInputType.number,
                    maxLength: 11,
                    decoration: const InputDecoration(
                      hintText: 'Enter Mobile Number',
                      icon: Icon(Icons.mobile_friendly),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$'))
                    ],
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                              .hasMatch(value)) {
                        return 'Enter Correct Mobile Number';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // DropdownButton<String>(
                  //   value: dropdownValue,
                  //   underline: Container(
                  //     height: 15,
                  //   ),
                  //   onChanged: (String? newValue) {
                  //     setState(() {
                  //       dropdownValue = newValue!;
                  //     });
                  //   },
                  //   items: <String>['One', 'Sale', 'Rent']
                  //       .map<DropdownMenuItem<String>>((String value) {
                  //     return DropdownMenuItem<String>(
                  //       value: value,
                  //       child: Text(value),
                  //     );
                  //   }).toList(),
                  // ),

                  DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ),

                  RoundButton(
                      title: 'Upload',
                      loading: loading,
                      onTap: () async {
                        setState(() {
                          loading = true;
                        });

                        //user ids are unique
                         int id = DateTime.now().millisecondsSinceEpoch;

                        postRef .child('/UserVeriRequest/${id}')
                        .set({

                          'Owner Name' : namecontroller.text.toString(),
                          'Mobile Number': mobilecontroller.text.toString(),
                          'DropdownValue': dropdownValue.toString(),



                        }).then((value) {
                          setState(() {
                            loading = false;
                          });
                          Utils().toastMessage(
                              'Application Submited to our delar for verification');
                        }).onError((error, stackTrace) {
                          Utils().toastMessage(error.toString());
                          setState(() {
                            loading = false;
                          });
                        });
                      }),
                ]),
              ),
            ),
          )),
    );
  }
}


 ////Dropdown simple no value stored in firebase

                // DropdownButton<String>(
                //   value: dropdownValue,
                //   underline: Container(
                //     height: 2,
                //   ),
                //   onChanged: (String? value) {
                //     // This is called when the user selects an item.
                //     setState(() {
                //       dropdownValue = value!;
                //     });
                //   },
                //   items: list.map<DropdownMenuItem<String>>((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),



                // ),
