import 'package:eatoutroundabout/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Color? color;
  final Function? function;
  final bool? showShadow;
  final Icon? icon;
  final Color? textColor;
  final double? width;

  CustomButton({this.text, this.function, this.color, this.showShadow, this.icon, this.textColor, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? width,
      child: ElevatedButton.icon(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color ?? Colors.white), padding: MaterialStateProperty.all(EdgeInsets.zero)),
        label: Text(
          text!,
          style: TextStyle(color: textColor != null ? textColor : primaryColor),
          textAlign: TextAlign.center,
          textScaleFactor: 1,
        ),
        onPressed:()=>function!(),
        icon: icon ?? Icon(Icons.question_mark, color: Colors.transparent, size: 0),
      ),
    );
  }
}
