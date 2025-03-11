import 'package:flutter/cupertino.dart';
import 'appColor.dart';

class AppText extends StatelessWidget {
  AppText(this.text,{this.fontSize = 18,this.color = TextColor, this.textAlign, this.fontWeight});
  final String text;
  final TextAlign? textAlign;
  final double fontSize;
  final Color color;
  final FontWeight? fontWeight;

  Widget build(BuildContext context) {
    return Text(text,textAlign: textAlign, style: TextStyle(color:color,fontSize:fontSize, fontWeight: fontWeight));
  }

}