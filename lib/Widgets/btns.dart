import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miz_bazi/core/appText.dart';
import '../core/appColor.dart';
import 'Icon.dart';

class AppBtn extends StatelessWidget {
  AppBtn( {required this.text, required this.onPress, this.color = BtnColor});
  final String text;
  final Color color;
  final Function() onPress;

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
      onPressed: ()=>onPress(),
      child:Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: AppText(text),
      ),
    );
  }
}
class CircleBtn extends StatelessWidget {
  CircleBtn( {required this.onPress, this.color = BtnColor, required this.icon, this.text, this.size = 56});
  final IconData icon;
  final Color color;
  final String? text;
  final double size;
  final Function() onPress;

  @override
  Widget build(BuildContext context) =>text == null? iconbtn(context):iconTextbtn(context);

  Widget iconbtn(BuildContext context) {
    return ClipOval(
      child: Material(
        color: color, // Button color
        child: InkWell(
          splashColor: BtnShadowColor(opacity: 0.3), // Splash color
          onTap: ()=>onPress(),
          child: SizedBox(width: size, height: size, child: AppIcon(icon)),
        ),
      ),
    );
  }

  Widget iconTextbtn(BuildContext context) {
    return ClipOval(
        child:
        Container(
            color: color,
            height: 60,
            width: 60,
            child:InkWell(
              onTap: ()=>onPress(),
              child:
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                        child:
                        AppIcon(icon,)
                    ) ,
                    Padding(
                        padding: EdgeInsets.only(top: 1.0),
                        child:
                        Center(
                            child:
                            AppText(text!,fontSize: 10,color: TextColor2,))
                    ),
                  ]),
            )
        )
    );
  }

}
