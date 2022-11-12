import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class WebMainScreen extends StatefulWidget {
  const WebMainScreen({Key? key}) : super(key: key);

  @override
  State<WebMainScreen> createState() => _WebMainScreenState();
}

class _WebMainScreenState extends State<WebMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('poop'),
    );
  }
}