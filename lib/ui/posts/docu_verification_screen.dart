import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp/utils/utils.dart';
import 'package:fyp/widgets/round_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home_Firebase_post_list.dart';
import 'home_navbar_post_screen.dart';

class DocuVerfiScreen extends StatefulWidget {
  const DocuVerfiScreen({Key? key}) : super(key: key);

  @override
  State<DocuVerfiScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<DocuVerfiScreen> {
  //text ko hold krty


  bool loading = false;
 



  //firebase firestore

  final firestore = FirebaseFirestore.instance.collection('UserApplication');

  //storage ref hai
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  


//firestore mai image save ho serf document verification wali

 File? _ImageDoc;
final pickerDoc = ImagePicker();
 
  //future function to pick single image
  Future imageDoc() async {
    //pickedFile user ke file hai
    final pickedDoc = await pickerDoc.pickImage(source: ImageSource.camera, imageQuality: 100);

    setState(() {
      //agre user ne file pick he nahi ke phir?
      if (pickedDoc != null) {
        _ImageDoc = File(pickedDoc.path);
      } else {
        print('No Image Picked');
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
         
          title: Center(
              child: Text(
            'Document Verification Form',
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
          )),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Please upload One picture of allotment letter or file',
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  imageDoc();
                },
                child: Container(
                  height: 100,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: Colors.amber,
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  child: _ImageDoc != null
                      ? Image.file(
                          _ImageDoc!.absolute,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        )
                      : Icon(Icons.camera_alt_outlined),
                ),
              ),
            ),

      const SizedBox(height: 50,),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
            RoundButton(
                title: 'Upload',
                loading: loading,
                onTap: () async {
                 setState(() {
                   loading = true;
                 });

                  //user ids are unique

                  //storage mai imaes aay ge
                     firebase_storage.Reference ref =
                     firebase_storage.FirebaseStorage.instance.ref(
                      '/allotmenletter/${DateTime.now().millisecondsSinceEpoch}');
                   UploadTask uploadTask = ref.putFile(_ImageDoc!.absolute);
                   await Future.value(uploadTask);
                  
                   var DocuImage = await ref.getDownloadURL();

                      firestore.doc().set({
                          'DocuImage': DocuImage.toString(),
                          'User ID': user?.uid.toString(),
                          'User Email': user!.email.toString(),
                         
                      }).then((value) {
                             setState(() {
                      loading = false;
                    });
                        Utils().toastMessage('Application Submited to our delar for verification');

                      }).onError((error, stackTrace)  {
                          Utils().toastMessage(error.toString());
                               setState(() {
                      loading = false;
                    });
                      });

              
                               Timer(const Duration(seconds: 3), () {
                           Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NavbarScreen())
            );

                });


                }),

          
          ]),
     ]   )
     ),
    );
  }
}
