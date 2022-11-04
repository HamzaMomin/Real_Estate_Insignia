import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
            
      child: ListView(children: [

        const SizedBox(height: 50,),
      
        Container(
           height: 100,
           color: const Color(0xFFBAB9FF),
           child: const Text('Locations', style: TextStyle(fontSize: 15 , ),),
           
        ),

        const SizedBox(height: 50,),
       
        Container(
          height: 100,
           color: const Color(0xFFBAB9FF),
            child: const Text('Housing Soceity List NOC', style: TextStyle(fontSize: 15 , ),),
        ),


       const SizedBox(height: 50,),
       
        Container(
          height: 100,
           color: const Color(0xFFBAB9FF),
            child: const Text('Price Range', style: TextStyle(fontSize: 15 , ),),
        ), 

      ],),


    );
  }
}