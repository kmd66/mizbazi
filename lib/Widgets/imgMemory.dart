import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../core/appColor.dart';

class AppImgMemory extends StatelessWidget {
  const AppImgMemory( {required this.image, this.size = 100, this.margin});
  final Uint8List image;
  final double size;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return
      Container(
        margin: margin,
        padding: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          color: BtnShadowColor(),
          shape: BoxShape.circle, // دایره‌ای کردن کانتاینر
          border: Border.all(
            color: BtnShadowColor(), // رنگ حاشیه کم‌رنگ
            width: 3, // ضخامت حاشیه
          ),
        ),
        child: ClipOval(
          child: Image.memory(
            image,
            height: size,
            width: size,
            fit: BoxFit.fill,
          ),
        ),
      );
  }
}