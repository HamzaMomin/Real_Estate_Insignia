import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class DealerScreen extends StatefulWidget {
  const DealerScreen({Key? key}) : super(key: key);

  @override
  State<DealerScreen> createState() => _WebMainScreenState();
}

class _WebMainScreenState extends State<DealerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Dealer screen')),
    );
  }
}