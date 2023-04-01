import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const[
          CupertinoActivityIndicator(),SizedBox(width: 15,),
           Text("Loading..."),
        ],
      ),
    );
  }
}
