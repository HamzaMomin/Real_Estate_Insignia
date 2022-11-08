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


class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  
  //text ko hold krty
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descontroller = TextEditingController();

  bool loading = false;
  final postRef = FirebaseDatabase.instance.ref().child('Post');
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Post');
  
  //storage ref hai
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;


          // ///multiple images will be selected from gallery internet ka code


  // final ImagePicker imagePicker = ImagePicker();
  // //images will be selected in list
  // List<XFile>? imageFileList = [];

  // void selectImages() async {
  //   final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
  //   if (selectedImages!.isNotEmpty) {
  //     imageFileList!.addAll(selectedImages);
  //   }
  //   setState(() {});
  // }


        File? _Image;
         final picker = ImagePicker();


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
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Center(
            child: InkWell(
              onTap: () {
                getImageGallery();
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
                child: _Image != null
                    ? Image.file(
                        _Image!.absolute,
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                      )
                    : Icon(Icons.camera_alt_outlined),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: titlecontroller,
            keyboardType: TextInputType.text,
            // minLines: 5,
            // maxLines: 10,
            decoration: const InputDecoration(
              labelText: 'Title',
              hintText: 'Enter the title',
              border: OutlineInputBorder(),
              labelStyle:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
              hintStyle:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter Tittle';
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: descontroller,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'Enter the Description',
              border: OutlineInputBorder(),
              labelStyle:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
              hintStyle:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter Description';
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
            'Details',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
          )),
          SizedBox(
            height: 20,
          ),
          RoundButton(
              title: 'Upload',
              loading : loading, 
              onTap: () async {
                setState(() {
                  loading = true;
                });

                try {
                  firebase_storage.Reference ref  =
                      firebase_storage.FirebaseStorage.instance.ref(
                          '/PropertyList/${DateTime.now().millisecondsSinceEpoch}');

                           UploadTask uploadTask = ref.putFile(_Image!.absolute);
                           await Future.value(uploadTask);
                           var newUrl  = await ref.getDownloadURL();

                            final User? user = auth.currentUser;
                           postRef.child('PostList').set({
                            //real time mai jaa k save ho ga

                                'Image Url' :newUrl.toString(),
                                'Image id' :DateTime.now().millisecondsSinceEpoch.toString(),
                                'Tittle' :  titlecontroller.text.toString(),
                                'Description' :  descontroller.text.toString(),
                                'User Email' :  user!.email.toString(),
                                'User ID' : user.uid.toString(),




                           }).then((value) => {
                              setState(() {
                            loading = false;
                                 }),

                              Utils().toastMessage('Submited')
                           }).onError((error, stackTrace) => {
                              Utils().toastMessage(error.toString()),
                                setState(() {
                            loading = false;
                                 }),
                           });


                } catch (e) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage(e.toString());
                }
              })
        ]),
      )
      );
    
  }
}

                          //asif taj blog video ka code dialog box open ho ga 

  // void dialog(context)
  // {
  //   showDialog(context: context,
  //    builder: (BuildContext context){
  //     return AlertDialog(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10.0)
  //       ),

  //     );
  //     // ignore: dead_code
  //     Container(
  //         height: 120,
  //         child: Column(
  //           children: [
  //           InkWell(
  //             onTap: (){

  //             },
  //             child: ListTile(
  //               leading: Icon(Icons.camera),
  //               title : Text('Camera')
  //             ),
  //           ),
  //           InkWell(
  //             onTap: (){

  //             },
  //             child: ListTile(
  //               leading: Icon(Icons.photo),
  //               title : Text('Gallery')
  //             ),
  //           )
  //         ]),
  //     );
  //    });
  // }
