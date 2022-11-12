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
        // appBar: AppBar(
        //   backgroundColor: Colors.deepPurpleAccent,
        //   automaticallyImplyLeading: false,
        //   title: const Center(
        //       child: Text(
        //     'Submited Applications',
        //     style: TextStyle(
        //         fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
        //   )),
        // ),
        body: Column(
          children: [
              Expanded(
                child: FirebaseAnimatedList(
                query: postRef.child('UserVeriRequest') ,
                itemBuilder:  (context, snapshot, animation, index) 
                {
          
              return Column(
                children: [
                  FadeInImage.assetNetwork(
                    placeholder: 'assets/Logo.png', 
                    image: snapshot.child('Image Url').value.toString()
                    ),
                   Text(snapshot.child('Image id').value.toString()),
                    Text(snapshot.child('Name').value.toString()),
                     Text(snapshot.child('PLot File Number').value.toString()),
                     

                ]
              );

                }),
                ),

                
                
                

          ],
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