import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        
        body: Center(
          child: Text('Page 2' , style:  TextStyle(fontSize:  30, fontWeight: FontWeight.bold
          )
        ),
      )
      ),
    );
  }
}
