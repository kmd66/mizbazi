import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../core/appColor.dart';

class AppInput extends StatelessWidget {
  const AppInput( {required this.text,this.maxLength, this.counterText,  this.onChanged, this.keyboardType, this.controller, this.ltr = false, this.margin});
  final String text;
  final EdgeInsetsGeometry? margin;
  final bool ltr;
  final TextInputType? keyboardType;
  final int? maxLength;
  final String? counterText;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return  Directionality(textDirection:keyboardType == TextInputType.number || ltr? TextDirection.ltr:TextDirection.rtl,
        child:Container(
            margin: margin,
            child: TextField(
              controller: controller,
              maxLength: maxLength,
              style: TextStyle(color: TextColor),
              keyboardType: keyboardType, // فعال کردن صفحه‌کلید عدد
              decoration: InputDecoration(
                counterText: counterText,
                labelText: text,
                labelStyle: TextStyle(color: TextColor2),
                floatingLabelStyle: TextStyle(color: LinkColor),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: TextColor2), // رنگ مرز در حالت غیرفعال
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: LinkColor, width: 2.0), // رنگ مرز در حالت فوکوس
                ),
              ),
              onChanged: (value) {
                if(onChanged != null)
                  onChanged!(value);
              },
            )
        )
    );
  }
}