import 'package:flutter/cupertino.dart';
import 'appColor.dart';

class AppText extends StatelessWidget {
  AppText(this.text,{this.fontSize = 18,this.color = TextColor, this.textAlign,});
  final String text;
  final TextAlign? textAlign;
  final double fontSize;
  final Color color;

  Widget build(BuildContext context) {
    return Text(text,textAlign: textAlign, style: TextStyle(color:color,fontSize:fontSize));
  }

}