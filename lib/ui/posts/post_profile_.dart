import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp/utils/utils.dart';
import 'package:fyp/widgets/round_button.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../auth/login_firebase.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool loading = false;
  File? _Image;
  final picker = ImagePicker();

  //storage ref hai
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Post');

  //future function to pick single image
  Future getImageGallery() async {
    //pickedFile user ke file hai
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    setState(() {
      //agre user ne file pick he nahi ke phir?
      if (pickedFile != null) {
        _Image = File(pickedFile.path);
      } else {
        print('No Image Picked');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            Center(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      getImageGallery();
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      //if image is not equal to null so humray pass image hai
                      child: _Image != null
                          ? Image.file(
                              _Image!.absolute,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fill,
                            )
                          : Icon(Icons.camera_alt_outlined),
                    ),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            RoundButton(
                title: 'Upload',
                loading: loading,
                onTap: () async {
                  setState(() {
                    loading = true;
                  });

                  //ref laya image ka or us ko ka aik folder banya jis ka naam UserProfiePic hai or us mai haar baar image jaab upload ho ge to unique ho ge us ka naam DateTime se lia jaay a //MOMIN
                  firebase_storage.Reference ref =
                      firebase_storage.FirebaseStorage.instance.ref(
                          '/UserProfilePic/${DateTime.now().millisecondsSinceEpoch}');
                  firebase_storage.UploadTask uploadTask =
                      ref.putFile(_Image!.absolute);

                  //jaab picture upload ho ge taab ye wait kry ga
                  Future.value(uploadTask).then((value) async {
                    //or image jaab store ho gee us ka link wapis aay ga from firebase storage

                    var newUrl = await ref.getDownloadURL();

                    databaseRef.child('UserProfile').set({
                      //haar baar unique ids ho gee
                      'id' : DateTime.now().millisecondsSinceEpoch.toString(),
                      'Profile id': user!.uid.toString(),
                      'Image Link': newUrl.toString(),
                      'User Email': user?.email.toString(),
                      


                    }).then((value) {
                      setState(() {
                        loading = false;
                      });
                      Utils().toastMessage('uploaded');
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                      setState(() {
                        loading = false;
                      });
                    });
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                    setState(() {
                      loading = false;
                    });
                  });
                }),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(

                  'Login as: ${FirebaseAuth.instance.currentUser!.email}',
                  style: TextStyle(fontSize: 20),

                ),

           

              ],
            ),
            SizedBox(
              height: 50,
            ),
            
         SizedBox(height: 10,),

               Text(

                  'Profile ID: ${FirebaseAuth.instance.currentUser!.uid}',
                  style: TextStyle(fontSize: 20),

                ),

            //logout
            IconButton(
                onPressed: () {
                  auth
                      .signOut()
                      .then((value) => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LoginFirebase()))
                          })
                      .onError((error, stackTrace) => {});
                },
                icon: Icon(Icons.logout_outlined)),
          ],
        ),
      ),
    );
  }
}

// Text(
//           'Login as: ${FirebaseAuth.instance.currentUser!.email}',
//           style: TextStyle(fontSize: 20),
//         ),

