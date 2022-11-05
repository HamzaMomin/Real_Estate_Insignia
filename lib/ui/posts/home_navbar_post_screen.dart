import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fyp/ui/auth/login_firebase.dart';
import 'package:fyp/ui/posts/post_profile_.dart';
import 'package:fyp/utils/utils.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({Key? key}) : super(key: key);

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  final auth = FirebaseAuth.instance;

  final user = FirebaseAuth.instance.currentUser;

  //Naviagtion bar elements

  int _selectedIndex = 0;
  static const List<Widget> _screens = <Widget>[
    Text('Home Page',
        style: TextStyle(
          fontSize: 15,
        )),
    Text('Search Page',
        style: TextStyle(
          fontSize: 15,
        )),
    UserProfileScreen(),
  ];

  //on tap jaab press kro to

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // final ref = FirebaseDatabase.instance.ref('REI_DATABASE');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.blueGrey,
        // appBar: AppBar(
        //   title: Text('Profile'),
        //     automaticallyImplyLeading: false,
        //   actions: [
        //     IconButton(
        //         onPressed: () {
        //           //sign out profile
        //           auth.signOut().then((value) {
        //             Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                     builder: (context) => const LoginFirebase()));
        //           }).onError((error, stackTrace) {
        //             Utils().toastMessage(error.toString());
        //           });
        //         },
        //         icon: Icon(Icons.logout_outlined)),
        //     SizedBox(
        //       width: 10,
        //     )
        //   ],
        // ),

        body: Center(
          child: _screens.elementAt(_selectedIndex),
        ),

        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.upload,
                color: Colors.black,
              ),
              label: 'Upload',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              label: 'Profile',
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 20,
          onTap: _onItemTapped,
          // elevation: 5
        ),

        //user ke email display ho ge jo auth mai hai firebase
        // Text('Email: ${FirebaseAuth.instance.currentUser!.email}'),
      ),
    );
  }
}

// Column(
//             children: [
//               Stack(children: <Widget>[
//                 Container(
//                     height: 200,
//                     width: double.maxFinite,
//                     decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(40),
//                           bottomRight: Radius.circular(40)),
//                       color: Colors.lightBlue,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: const [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 30),
//                           child: Text('Name',
//                               style: TextStyle(
//                                 fontSize: 25,
//                                 fontWeight: FontWeight.w300,
//                               )),
//                         )
//                       ],
//                     )),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     height: 150,
//                     width: 150,

//                     // ignore: prefer_const_constructors
//                     decoration: ShapeDecoration(
//                       color: Colors.grey,
//                       shape: CircleBorder(),
//                     ),

//                     //person icon
//                     child: IconButton(
//                       icon: const Icon(Icons.person_add_alt_1_rounded),
//                       color: Colors.black,
//                       iconSize: 25,
//                       onPressed: () {},
//                     ),
//                   ),
//                 ),
//               ]),
//               const SizedBox(
//                 height: 15,
//               ),
//             ],
//           )
