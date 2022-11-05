
import 'package:flutter/material.dart';

class ImageClick extends StatelessWidget {
  const ImageClick({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          shape:
          const Border(bottom: BorderSide(color: Colors.black, width: 2)
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),

          body: Center(
            child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              // ignore: prefer_const_literals_to_create_immutables
              colors: [
                Colors.blue,
                Colors.red,
              ],
                ),
            ),
          ),

      ),
    )
    );
  }
}