import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miz_bazi/core/appText.dart';
import '../core/appColor.dart';

class AppBtn extends StatelessWidget {
  AppBtn( {required this.text, required this.onPressed, this.color = BtnColor});
  final String text;
  final Color color;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        shadowColor:BtnShadowColor(),
        elevation: 3.0,
        backgroundColor:color,
      ),
      onPressed: ()=>onPressed(),
      child:Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: AppText(text),
      ),
    );
  }
}
class CircleBtn extends StatelessWidget {
  CircleBtn( {required this.onPressed, this.color = BtnColor, required this.icon});
  final IconData icon;
  final Color color;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: color, // Button color
        child: InkWell(
          splashColor: BtnShadowColor(opacity: 0.3), // Splash color
          onTap: ()=>onPressed(),
          child: SizedBox(width: 56, height: 56, child: Icon(icon, color: TextColor2,)),
        ),
      ),
    );
  }
}