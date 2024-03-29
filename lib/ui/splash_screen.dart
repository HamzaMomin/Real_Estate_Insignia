import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fyp/firebase_services/splash_services.dart';



class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  
  SplashServices splashServices = SplashServices();
  
  @override
 void initState() {
    // TODO: implement initState
    super.initState();
    splashServices.isLogin(this.context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff002a62),
      body: Center(
        // ignore: prefer_const_literals_to_create_immutables
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/Logo.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              // ignore: avoid_unnecessary_containers
              child: Container(
                child: const Text(
                  'FYP',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
