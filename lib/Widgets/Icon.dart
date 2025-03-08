import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../core/appColor.dart';

class AppIcon extends StatelessWidget {
  const AppIcon( this.icon, {this.color = TextColor2, this.size});
  final IconData icon;
  final Color color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: size,color: color,);
  }
}