import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber,
        body: Center(

          child: Text('Splash Screen with firebase' , style: TextStyle(fontSize: 25),),
        ),
        
      ),
    );

  }
}