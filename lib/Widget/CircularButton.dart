import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final VoidCallback onPress;

  const CircularButton({Key? key, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Positioned(
            left: 0,
            top: 0,
            child: SizedBox(
                height: 48,
                width: 48,
                child: CircularProgressIndicator(strokeWidth: 1,color: Colors.black,))),
        RawMaterialButton(onPressed: onPress,
          child: Icon(Icons.arrow_forward,color: Colors.white,),
          fillColor: Colors.black,
          padding: EdgeInsets.all(7),
          shape: CircleBorder(),
          constraints: BoxConstraints(maxHeight: 40,maxWidth: 40),
        ),
      ],
    );
  }
}
