import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreenFirebase extends StatefulWidget {
  const HomeScreenFirebase({Key? key}) : super(key: key);

  @override
  State<HomeScreenFirebase> createState() => _HomeScreenState();
}

bool loading = false;
final postRef = FirebaseDatabase.instance.ref().child('UserApplication');

class _HomeScreenState extends State<HomeScreenFirebase> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.red.shade50,
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              Expanded(
                child: FirebaseAnimatedList(
                    query: postRef.child('UserVeriRequest'),
                    itemBuilder: (context, snapshot, animation, index) {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: FadeInImage.assetNetwork(
                                  fit: BoxFit.fill,
                                  height: 350,
                                  width: 350,
                                  placeholder: 'assets/Logo.png',
                                  image: snapshot
                                      .child('Image Url')
                                      .value
                                      .toString()),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height: 50,
                                  width: 120,
                                  color: Colors.deepPurpleAccent,
                                  child: Center(
                                      child: Text(snapshot
                                          .child('User Name')
                                          .value
                                          .toString())),
                                ),
                                SizedBox(width: 90),
                                Container(
                                  height: 50,
                                  width: 120,
                                  color: Colors.red,
                                  child: Center(
                                      child: Text(snapshot
                                          .child('Mobile Number')
                                          .value
                                          .toString(), )),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Society Name : '),
                                Text(snapshot
                                    .child('Society Name')
                                    .value
                                    .toString()),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ]);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



    // StreamBuilder<QuerySnapshot>(
    //             stream: FirebaseFirestore.instance
    //                 .collection('PropertyList')
    //                 .snapshots(),
    //             builder: (BuildContext context,
    //                 AsyncSnapshot<QuerySnapshot> snapshot) {
    //               if (snapshot.connectionState == ConnectionState.waiting) {
    //                 return CircularProgressIndicator();
    //               }
    //               if (snapshot.hasError) {
    //                 return Text('Connection Error');
    //               }
    //               // ignore: dead_code
    //               return Expanded(
    //                   child: ListView.builder(
    //                       itemCount: snapshot.data!.docs.length,
    //                       itemBuilder: (context, index) {
    //                         return Column(children: [
    //                           Container(
    //                             child: Text(snapshot.data!.docs[index]['User Email']
    //                                 .toString()),
    //                           )
    //                         ]);
    //                       }));
    //             }),