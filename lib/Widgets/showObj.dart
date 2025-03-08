import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ShowObj extends StatelessWidget{
  const ShowObj({required this.obj, this.animat = false, required this.isShow});
  final bool animat;
  final bool isShow;
  final Widget obj;

  Widget build(BuildContext context) {
    if(!isShow) {
      return Container(width: 0,height: 0,);
    }
    if(animat) {
      return
        AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: !isShow
                ? SizedBox()
                : obj// more of the related code
        );
    } else {
      if (isShow) {
        return obj;
      } else {
        return Container(width: 0, height: 0,);
      }
    }
  }

}