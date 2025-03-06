import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miz_bazi/core/appText.dart';
import '../core/appColor.dart';

class AppBtn extends StatelessWidget {
  AppBtn( {required this.text, this.onPressed, this.color = BtnColor});
  final String text;
  final Color color;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor:BtnShadowColor,
        elevation: 3.0,
        backgroundColor:color,
      ),
      onPressed: () {
        if(onPressed != null) {
          onPressed!();
        }
      },
      child:Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: AppText(text),
      ),
    );
  }
}