import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class container extends StatefulWidget {
  const container({Key? key}) : super(key: key);

  @override
  State<container> createState() => _containerState();
}

class _containerState extends State<container> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: [

        ],),
      ),
    );
  }
}
