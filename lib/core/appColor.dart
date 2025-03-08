import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

const Color BackgroundColor = Color.fromRGBO(20, 30, 48, 1.0);
const Color BaseColor = Color.fromRGBO(0, 71, 91, 1.0);
const Color TextColor = Color.fromRGBO(200, 200, 200, 1.0);
const Color TextColor2 = Color.fromRGBO(207, 216, 236, 0.6);
const Color LinkColor = Color.fromRGBO(3, 218, 198, 1);
const Color BtnColor = Color.fromRGBO(66, 72, 101, 1.0);
Color BtnShadowColor ({double opacity = 0.3})=> Color.fromRGBO(207, 216, 236, opacity);

const Color ErrorColor = Color.fromRGBO(207, 102, 121, 1);
const Color SuccessColor = Color.fromRGBO(76, 175, 80, 1);
// const Color SuccessColor = Color.fromRGBO(207, 102, 121, 1);


enum MessageType {
  Danger,
  Warning,
  Info,
  Message
}
class MessageColor {
  static type(MessageType type) {
    if(type == MessageType.Info)
      return SuccessColor;
    if(type == MessageType.Danger)
      return ErrorColor;
    if(type == MessageType.Warning)
      return Colors.amber;
    return Colors.lightBlueAccent;
  }
  static icon(  MessageType type) {
    if(type == MessageType.Info)
      return Iconsax.information;
    if(type == MessageType.Danger)
      return Iconsax.danger;
    if(type == MessageType.Warning)
      return Iconsax.warning_2;
    return Icons.mail_outlined;
  }
}