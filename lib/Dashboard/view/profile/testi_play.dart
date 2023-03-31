import 'package:flutter/material.dart';
class play extends StatefulWidget {
  const play({Key? key}) : super(key: key);

  @override
  State<play> createState() => _playState();
}

class _playState extends State<play> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("hello"),),
    );
  }
}
