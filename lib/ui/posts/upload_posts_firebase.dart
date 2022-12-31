import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/utils/utils.dart';
import 'package:fyp/widgets/round_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'docu_verification_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  //text ko hold krty
  TextEditingController namecontroller = TextEditingController();
  TextEditingController cniccontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController plotcontroller = TextEditingController();
  TextEditingController pDcontroller = TextEditingController();
  TextEditingController descricontroller = TextEditingController();
  TextEditingController socitycontroller = TextEditingController();
  TextEditingController purposecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController sizeplotcontroller = TextEditingController();
  // TextEditingController dealertcontroller = TextEditingController();

@override

  void initState() {
    super.initState();
    namecontroller = TextEditingController(text: 'User Name');
  }

  bool loading = false;
  final postRef = FirebaseDatabase.instance.ref().child('UserApplication');

  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Post');

  //firebase firestore

  final firestore = FirebaseFirestore.instance.collection('UserApplication');

  //storage ref hai
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
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
  final _formkey = GlobalKey<FormState>();
 
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

  // var select;
  // final List<String> _noc = <String>[
  //   'DHA',
  //   'Jinnah Gardern',
  //   'Naval Anchorage',
  //   'Bahria Town',
  // ];

//firestore mai image save ho serf document verification wali

//  File? _ImageDoc;
// final pickerDoc = ImagePicker();

//   //future function to pick single image
//   Future imageDoc() async {
//     //pickedFile user ke file hai
//     final pickedDoc = await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

//     setState(() {
//       //agre user ne file pick he nahi ke phir?
//       if (pickedDoc != null) {
//         _Image = File(pickedDoc.path);
//       } else {
//         print('No Image Picked');
//       }
//     });
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          automaticallyImplyLeading: true,
          title: Center(
              child: Text(
            'Property List Form Step 2',
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
          )),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Please upload One picture of House or Plot',
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: _formkey,
              child: Center(
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
            ),
            SizedBox(
              height: 20,
            ),
            // TextFormField(
            //   controller: titlecontroller,
            //   keyboardType: TextInputType.text,
            //   // minLines: 5,
            //   // maxLines: 10,
            //   decoration: const InputDecoration(
            //     labelText: 'Title',
            //     hintText: 'Enter the title',
            //     border: OutlineInputBorder(),
            //     labelStyle:
            //         TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
            //     hintStyle:
            //         TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
            //   ),
            //   validator: (value) {
            //     if (value!.isEmpty) {
            //       return 'Enter Tittle';
            //     }
            //     return null;
            //   },
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // TextFormField(
            //   controller: descontroller,
            //   keyboardType: TextInputType.text,
            //   decoration: const InputDecoration(
            //     labelText: 'Description',
            //     hintText: 'Enter the Description',
            //     border: OutlineInputBorder(),
            //     labelStyle:
            //         TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
            //     hintStyle:
            //         TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
            //   ),
            //   validator: (value) {
            //     if (value!.isEmpty) {
            //       return 'Enter Description';
            //     }
            //     return null;
            //   },
            // ),
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

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // TextFormField(
                  //   controller: namecontroller,
                  //   keyboardType: TextInputType.text,
                  //   decoration: const InputDecoration(
                  //     hintText: 'Enter Owner Name',
                  //     icon: Icon(Icons.person_outline),
                  //   ),
                  //   inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[a-z A-Z]+$'))],
                  //   validator: (value) {
                  //     if (value!.isEmpty ||
                  //         !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                  //       return 'Enter Correct Owner Name';
                  //     } else {
                  //       return null;
                  //     }
                  //   },
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // TextFormField(
                  //   maxLength: 13,
                  //   controller: cniccontroller,
                  //   keyboardType: TextInputType.number,
                  //   decoration: const InputDecoration(
                  //     hintText: 'CNIC',
                  //     icon: Icon(Icons.pages_rounded),
                  //   ),
                  //    validator: MultiValidator([
                  //       RequiredValidator(errorText: 'Required'),
                  //       PatternValidator(r'^[a-zA-z]+([\s][a-zA-Z]+)*$', errorText: 'Enter CNIC')
                  //     ]),
                  //   // validator: (value) {
                  //   //   if (value!.isEmpty ||
                  //   //       !RegExp(r'^[0-9]+$').hasMatch(value)) {
                  //   //     return 'Enter CNIC';
                  //   //   } else {
                  //   //     return null;
                  //   //   }
                  //   // },
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  // TextFormField(
                  //   controller: mobilecontroller,
                  //   keyboardType: TextInputType.number,
                  //   maxLength: 11,
                  //   decoration: const InputDecoration(
                  //     hintText: 'Mobile Number',
                  //     icon: Icon(Icons.mobile_friendly),
                  //   ),
                  //    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$'))],
                  //   validator: (value) {
                  //     if (value!.isEmpty ||
                  //         !RegExp(r'^[0-9]+$').hasMatch(value)) {
                  //       return 'Enter Mobile Number';
                  //     } else {
                  //       return null;
                  //     }
                  //   },
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'NOC / LOP Approved Housing Societies of Islamabad',
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: const <Widget>[
                  //     DropdownButton(

                  //       items: _noc
                  //           .map((value) => DropdownMenuItem(

                  //                 child: Text(
                  //                   value,
                  //                 ),
                  //                 value: value,
                  //               )
                  //               )
                  //           .toList(),
                  //       onChanged: (selectnoctype) {
                  //         setState(() {
                  //           select = selectnoctype;
                  //           validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'Choose Options';
                  //     }
                  //     return null;
                  //   };

                  //         });
                  //       },
                  //       value: select,
                  //       isExpanded: false,
                  //       hint: Text('Choose one Housing Socity'),

                  //     ),

                  //   ],
                  // ),

                  // TextFormField(
                  //   maxLength: 10,
                  //   controller: socitycontroller,
                  //   keyboardType: TextInputType.text,
                  //   decoration: const InputDecoration(
                  //     hintText: 'Enter Society Name :',
                  //     icon: Icon(Icons.area_chart_outlined),
                  //   ),
                  //   validator: (value) {
                  //     if (value!.isEmpty ||
                  //         !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                  //       return 'Enter Society Name';
                  //     } else {
                  //       return null;
                  //     }
                  //   },
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // TextFormField(
                  //   maxLength: 10,
                  //   controller: plotcontroller,
                  //   keyboardType: TextInputType.text,
                  //   decoration: const InputDecoration(
                  //     hintText: 'Enter Plot Or File Number Series',
                  //     icon: Icon(Icons.numbers_outlined),
                  //   ),
                  //   validator: (value) {
                  //     if (value!.isEmpty ||
                  //         !RegExp(r'^[a-z A-Z][0-9]+$').hasMatch(value)) {
                  //       return 'Enter Plot Or File Number Series';
                  //     }
                  //     else {return null;
                  //     }
                  //   },
                  // ),

                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    maxLength: 10,
                    controller: sizeplotcontroller,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'Plot Size : ',
                      icon: Icon(Icons.landscape_outlined),
                    ),
                     inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$'))],
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Enter Mobile Number';
                      } else {
                        return null;
                      }
                    },
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    maxLength: 4,
                    controller: purposecontroller,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'Purpose : Sale / Rent',
                      icon: Icon(Icons.tab_outlined),
                    ),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[a-z A-Z]+$'))],
                   validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                        return 'Enter Mobile Number';
                      } else {
                        return null;
                      }
                    },
                  ),
                  //pricecontroller
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    maxLength: 10,
                    controller: pricecontroller,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'Price  : ',
                      icon: Icon(Icons.price_change_outlined),
                    ),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[a0-z9]+$'))],
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[a0-z9]+$').hasMatch(value)) {
                        return 'Enter Price';
                      } else {
                        return null;
                      }
                    },
                  ),

                  // SizedBox(
                  //   height: 20,
                  // ),

                  // TextFormField(
                  //   controller: pDcontroller,
                  //   keyboardType: TextInputType.text,
                  //   minLines: 5,
                  //   maxLines: 10,
                  //   decoration: const InputDecoration(
                  //     hintText: 'Enter Property Location',
                  //     labelText: 'Enter Location',
                  //     icon: Icon(Icons.location_city_outlined),
                  //     border: OutlineInputBorder(),
                  //     labelStyle: TextStyle(
                  //         color: Colors.black, fontWeight: FontWeight.normal),
                  //     hintStyle: TextStyle(
                  //         color: Colors.grey, fontWeight: FontWeight.normal),
                  //   ),
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'Enter Details';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  SizedBox(
                    height: 20,
                  ),

                  TextFormField(
                    controller: descricontroller,
                    keyboardType: TextInputType.text,
                    minLines: 5,
                    maxLines: 20,
                    decoration: const InputDecoration(
                      hintText: 'Enter  Description',
                      labelText: 'Description',
                      icon: Icon(Icons.description),
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                      hintStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.normal),
                    ),
                     inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[a-z A-Z]+$'))],
                     validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                        return 'Enter Price';
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Text(
              'Only Verified Properties will be Listed',
              style: TextStyle(color: Colors.red),
            ),

            const SizedBox(
              height: 15,
            ),

            RoundButton(
                title: 'Upload',
                loading: loading,
                onTap: () async {
                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                  }

                  //user ids are unique

                  //storage mai imaes aay ge
                  //    firebase_storage.Reference ref =
                  //    firebase_storage.FirebaseStorage.instance.ref(
                  //     '/allotmenletter/${DateTime.now().millisecondsSinceEpoch}');
                  //  UploadTask uploadTask = ref.putFile(_Image!.absolute);
                  //  await Future.value(uploadTask);

                  //  var DocuImage = await ref.getDownloadURL();

                  //     firestore.doc().set({
                  //         'DocuImage': DocuImage.toString(),

                  //     }).then((value) {
                  //            setState(() {
                  //     loading = false;
                  //   });
                  //       Utils().toastMessage('Application Submited');

                  //     }).onError((error, stackTrace)  {
                  //         Utils().toastMessage(error.toString());
                  //              setState(() {
                  //     loading = false;
                  //   });
                  //     });

                  //firebase Real Time Data Base
                  try {
                    int id = DateTime.now().millisecondsSinceEpoch;

                    firebase_storage.Reference ref = firebase_storage
                        .FirebaseStorage.instance
                        .ref('/UserReq/${id}');

                    UploadTask uploadTask = ref.putFile(_Image!.absolute);
                    await Future.value(uploadTask);
                    var newUrl = await ref.getDownloadURL();

                    final User? user = auth.currentUser;
                    postRef
                        .child('/UserVeriRequest/${id}')
                        .set({
                          //real time mai jaa k save ho ga

                          'Image Url': newUrl.toString(),
                          'Image id': id,
                          'User Name': namecontroller.text.toString(),
                          // 'CNIC': cniccontroller.text.toString(),
                          'User Email': user!.email.toString(),
                          'User ID': user.uid.toString(),
                          // 'PLot File Number': plotcontroller.text.toString(),
                          'Mobile Number': mobilecontroller.text.toString(),
                          // 'Property details': pDcontroller.text.toString(),
                          'Description': descricontroller.text.toString(),
                          // 'Society Name': socitycontroller.text.toString(),
                          'Purpose': purposecontroller.text.toString(),
                          'Price': pricecontroller.text.toString(),
                          'Plot Size': sizeplotcontroller.text.toString(),
                          // 'DealerVeri': dealertcontroller.text.toString(),
                        })
                        .then((value) => {
                              setState(() {
                                loading = false;
                              }),
                              Utils().toastMessage('Application Submited')
                            })
                        .onError((error, stackTrace) => {
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

                  //jaab submission ho jaay taab next screen mai jaay likn wait kry phely

                  Timer(const Duration(seconds: 3), () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DocuVerfiScreen()));
                  });
                }),

            SizedBox(
              height: 10,
            ),
          ]),
        ));
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
