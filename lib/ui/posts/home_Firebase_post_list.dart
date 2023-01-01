// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreenFirebase extends StatefulWidget {
  const HomeScreenFirebase({Key? key}) : super(key: key);

  @override
  State<HomeScreenFirebase> createState() => _HomeScreenState();
}

bool loading = false;
final postRef = FirebaseDatabase.instance.ref().child('UserApplication');

var select;
final List<String> _noc = <String>[
  'DHA',
  'Jinnah Gardern',
  'Naval Anchorage',
  'Bahria Town',
];

class _HomeScreenState extends State<HomeScreenFirebase> {
  TextEditingController searchcontroller = TextEditingController();
  TextEditingController searchcontroller2 = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  String search = "";

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final firestore = FirebaseFirestore.instance.collection('Veri').snapshots();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.red.shade50,
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.list),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
        ),
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  maxLength: 15,
                  controller: searchcontroller,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Search by Society Name',
                    icon: Icon(Icons.search),
                  ),
                  onChanged: (String value) {
                    search = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Following is the list of Noc Societies in Islamabad',
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox(
                  height: 5,
                ),
                DropdownButton(
                  items: _noc
                      .map((value) => DropdownMenuItem(
                            child: Text(
                              value,
                            ),
                            value: value,
                          ))
                      .toList(),
                  onChanged: (selectnoctype) {
                    setState(() {
                      select = selectnoctype;
                      validator:
                      (value) {
                        if (value!.isEmpty) {
                          return 'Choose Options';
                        }
                        return null;
                      };
                    });
                  },
                  value: select,
                  isExpanded: false,
                  hint: Text('Choose one Housing Socity'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLength: 15,
                  controller: searchcontroller2,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      hintText: 'Search by Plot Size',
                      icon: Icon(Icons.send_and_archive)),
                  onChanged: (String value) {
                    search = value;
                  },
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [

              

                            
                
              Expanded(
                child: FirebaseAnimatedList(
                    query: postRef.child('UserVeriRequest'),
                    itemBuilder: (context, snapshot, animation, index) {
                      String tempvalue =
                          snapshot.child('Society Name').value.toString();
                      String tempvalue2 =
                          snapshot.child('Plot Size').value.toString();
                      if (searchcontroller.text.isEmpty) {
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

                              Divider(
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: 50,
                                      width: 120,
                                      color: Colors.deepPurple,
                                      child: Center(
                                        child: Text(
                                            snapshot
                                                .child('Price')
                                                .value
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 90),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: 50,
                                      width: 120,
                                      color: Colors.deepPurple,
                                      child: Center(

                                          // ignore: deprecated_member_use
                                          child: InkWell(
                                              child: Text(
                                                  snapshot
                                                      .child('Mobile Number')
                                                      .value
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                  )),
                                              onTap: () {
                                                launch('tel:' +
                                                    snapshot
                                                        .child('Mobile Number')
                                                        .value
                                                        .toString());
                                              }
                                              // '${FirebaseAuth.instance.currentUser?.phoneNumber}'

                                              )
                                          // child: Text(
                                          //     snapshot
                                          //         .child('Mobile Number')
                                          //         .value
                                          //         .toString(),
                                          //     style: TextStyle(
                                          //       fontSize: 18,
                                          //       color: Colors.white,
                                          //     )
                                          //     )
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Society Name : ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  Text(snapshot
                                      .child('Society Name')
                                      .value
                                      .toString()),
                                  SizedBox(
                                    width: 90,
                                  ),
                                  Text('Purpose : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700)),
                                  Text(snapshot
                                      .child('Sell Rent')
                                      .value
                                      .toString()),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Plot Size : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700)),
                                  Text(snapshot
                                      .child('Plot Size')
                                      .value
                                      .toString()),
                                  const SizedBox(
                                    width: 70,
                                  ),
                                  const Text('Name : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700)),
                                  Text(snapshot
                                      .child('User Name')
                                      .value
                                      .toString()),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text('Property details : ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700)),
                              Text(snapshot
                                  .child('Property details')
                                  .value
                                  .toString()),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Email : ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700)),
                              const SizedBox(
                                width: 50,
                              ),
                              Text(
                                  snapshot.child('User Email').value.toString(),
                                  style: TextStyle(color: Colors.blueGrey)),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Description : ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700)),
                              Text(snapshot
                                  .child('Description')
                                  .value
                                  .toString()),

                              SizedBox(
                                height: 10,
                              ),

                              Text(
                                'User ID: ',
                                style: TextStyle(color: Colors.black),
                              ),

                              Text(
                                snapshot.child('User ID').value.toString(),
                                style: TextStyle(color: Colors.red),
                              ),

                              SizedBox(
                                height: 10,
                              ),

                              // ignore: dead_code

                              // const Text('Dealer Verification Status : ',
                              //     style:
                              //         TextStyle(fontWeight: FontWeight.w700)),

                              const SizedBox(
                                height: 40,
                              ),

                              Divider(
                                color: Colors.grey.shade800,
                              ),
                            ]);
                      } else if (tempvalue
                          .toString()
                          .contains(searchcontroller.text.toString())) {
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

                              Divider(
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [

                                     

                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: 50,
                                      width: 120,
                                      color: Colors.deepPurple,
                                      child: Center(
                                        child: Text(
                                            snapshot
                                                .child('Price')
                                                .value
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 90),

                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: 50,
                                      width: 120,
                                      color: Colors.deepPurple,
                                      child: Center(
                                          child: Text(
                                              snapshot
                                                  .child('Mobile Number')
                                                  .value
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                              ))),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  
                                  Text(
                                    'Society Name : ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  Text(snapshot
                                      .child('Housing Societies')
                                      .value
                                      .toString()),
                                  SizedBox(
                                    width: 90,
                                  ),
                                  Text('Purpose : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700)),
                                  Text(snapshot
                                      .child('Sell Rent')
                                      .value
                                      .toString()),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Plot Size : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700)),
                                  Text(snapshot
                                      .child('Plot Size')
                                      .value
                                      .toString()),
                                  const SizedBox(
                                    width: 70,
                                  ),
                                  const Text('Name : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700)),
                                  Text(snapshot
                                      .child('User Name')
                                      .value
                                      .toString()),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text('Property details : ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700)),
                              Text(snapshot
                                  .child('Property details')
                                  .value
                                  .toString()),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Email : ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700)),
                              Text(snapshot
                                  .child('User Email')
                                  .value
                                  .toString()),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Description : ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700)),
                              Text(snapshot
                                  .child('Description')
                                  .value
                                  .toString()),
                              SizedBox(
                                height: 10,
                              ),

                              Text(
                                'User ID: ',
                                style: TextStyle(color: Colors.black),
                              ),

                              Text(
                                snapshot.child('User ID').value.toString(),
                                style: TextStyle(color: Colors.red),
                              ),
                              
                              

                              // ignore: dead_code
                              const SizedBox(
                                height: 20,
                              ),

                              // const Text('Dealer Verification Status : ',
                              //     style:
                              //         TextStyle(fontWeight: FontWeight.w700)),

                              const SizedBox(
                                height: 40,
                              ),

                              Divider(
                                color: Colors.grey.shade800,
                              ),
                            ]);
                      } else if (tempvalue2
                          .toString()
                          .contains(searchcontroller.text.toString())) {
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

                              Divider(
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: 50,
                                      width: 120,
                                      color: Colors.deepPurple,
                                      child: Center(
                                        child: Text(
                                            snapshot
                                                .child('Price')
                                                .value
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 90),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: 50,
                                      width: 120,
                                      color: Colors.deepPurple,
                                      child: Center(
                                          child: Text(
                                              snapshot
                                                  .child('Mobile Number')
                                                  .value
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                              ))),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Society Name : ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  Text(snapshot
                                      .child('Society Name')
                                      .value
                                      .toString()),
                                  SizedBox(
                                    width: 90,
                                  ),
                                  Text('Purpose : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700)),
                                  Text(snapshot
                                      .child('Purpose')
                                      .value
                                      .toString()),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Plot Size : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700)),
                                  Text(snapshot
                                      .child('Plot Size')
                                      .value
                                      .toString()),
                                  const SizedBox(
                                    width: 70,
                                  ),
                                  const Text('Name : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700)),
                                  Text(snapshot
                                      .child('User Name')
                                      .value
                                      .toString()),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text('Property details : ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700)),
                              Text(snapshot
                                  .child('Property details')
                                  .value
                                  .toString()),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Email : ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700)),
                              Text(snapshot
                                  .child('User Email')
                                  .value
                                  .toString()),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Description : ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700)),
                              Text(snapshot
                                  .child('Description')
                                  .value
                                  .toString()),

                              // ignore: dead_code
                              const SizedBox(
                                height: 20,
                              ),

                              // const Text('Dealer Verification Status : ',
                              //     style:
                              //         TextStyle(fontWeight: FontWeight.w700)),
                             
                              const SizedBox(
                                height: 40,
                              ),

                              Divider(
                                color: Colors.grey.shade800,
                              ),
                            ]);
                      } else {
                        return Container(
                          child: Text('Connection Error'),
                        );
                      }
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