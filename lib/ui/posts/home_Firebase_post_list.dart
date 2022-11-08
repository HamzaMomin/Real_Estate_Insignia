import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class HomeScreenFirebase extends StatefulWidget {
  const HomeScreenFirebase({Key? key}) : super(key: key);

  @override
  State<HomeScreenFirebase> createState() => _HomeScreenState();
}

  final postRef = FirebaseDatabase.instance.ref().child('PostList');
  
class _HomeScreenState extends State<HomeScreenFirebase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.red.shade50,

      body: Column(
        children: [
          Expanded(
            
            child: FirebaseAnimatedList(query: postRef.child('PostList') ,
             itemBuilder:(context, snapshot, animation, index) {
              
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [

                      Container(
                        height: 350,
                        width: 350,
                        color: Colors.red,
                        child: Image(image: NetworkImage(snapshot.child('Image Url').value.toString()),
                        )
                      ) 
                  ],
                ),
              );
             }
             )
          ),
        ],
      ),
      
    
    );
  }
}