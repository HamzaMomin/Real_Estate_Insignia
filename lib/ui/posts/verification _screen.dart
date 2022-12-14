import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VeriScreen extends StatefulWidget {
  const VeriScreen({Key? key}) : super(key: key);

  @override
  State<VeriScreen> createState() => _VeriScreenState();
}

class _VeriScreenState extends State<VeriScreen> {
  
  bool loading = false;
 



  //firebase firestore

  final firestore = FirebaseFirestore.instance.collection('Veri').snapshots();


  final FirebaseAuth auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  
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

            StreamBuilder<QuerySnapshot>(
                stream: firestore,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return CircularProgressIndicator();

                  if (snapshot.hasError) return Text('Connection Error!!');

                  return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              subtitle: Text('User Property :'),
                              title: Center(
                                  child: Text(
                                snapshot.data!.docs[index]['Message']
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              )
                              ),
                             
                            );
                          }));
                },
              ),

        ]),




      ),
    );
  }
}
