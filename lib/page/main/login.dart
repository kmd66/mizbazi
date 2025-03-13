import 'package:flutter/material.dart';
import 'package:miz_bazi/core/extensions.dart';
import '../../Widgets/btns.dart';
import '../../Widgets/CounDown.dart';
import '../../Widgets/Input.dart';
import '../../core/appColor.dart';
import '../../core/appText.dart';
import '../../core/event.dart';
import '../../model/ApiModel.dart';
import '../../model/Message.dart';
import '../../services/loginService.dart';
import 'constText.dart';


enum _loginStateType {
  stampCode,
  phoneNumber,
}

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _State();
}

class _State extends State<Login> {
  var loginState = _loginStateType.phoneNumber;
  late TextEditingController _controller;
  var model = SendSecurityStampDto(phone: '', stamp: '');
  var _service = LoginService();
  CounDown counDown = CounDown(seconds: 120,);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 20),
      child: loginState == _loginStateType.phoneNumber?insertPhoneNumber(context):insertStamp(context),
    );
  }

  Widget insertPhoneNumber(BuildContext context) {
    _controller =  TextEditingController(text: model.phone);
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: AppText(SEND_SMS),
        ),
        AppInput(
          text: PHONE_NUMBER,
          controller: _controller,
          keyboardType : TextInputType.number,
          maxLength: 11,
          counterText: null,
          onChanged: (value )=>model.phone= value,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: AppBtn(
            text: SEND,
            onPress: ()=>sendPhoneNumber(),
          ),
        ),
      ],
    );
  }

  Widget insertStamp(BuildContext context) {
    // counDown.reset();
    _controller =  TextEditingController(text: model.stamp);
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: AppText(SEND_SECURITYSTAMP),
        ),
        AppInput(
          text: SECURITYSTAMP,
          controller: _controller,
          keyboardType : TextInputType.number,
          maxLength: 5,
          counterText: null,
          onChanged: (value )=>model.stamp= value,
        ),
        counDown,
        Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppBtn(
              color: SuccessColor,
              text: SEND,
              onPress: ()=>sendSecurityStamp(),
            ),
            AppBtn(
              color: TextColor2,
              text: CANCEL,
              onPress: ()=> setState(()=> loginState = _loginStateType.phoneNumber),
            ),
          ]
        )
      ],
    );
  }

  void sendPhoneNumber() {
    if(model.phone?.length != 11 || model.phone![0] != "0" || model.phone![1] != "9"){
      streamMessage.add(Message.danger(msg:PHONE_NUMBER_ERROR, respite: 2));
      return;
    }
    streamMessage.add(Message.info(
        btnTitle: SEND,
        exit: true,
        msg: SEND_SMS_VERIFY.sprintf([model.phone!]),
        onOk: ()=>_service.GetUser(model,()=>setState(()=> loginState = _loginStateType.stampCode))
    ));
  }

  void sendSecurityStamp() async{
    if(model.stamp?.length != 5){
      streamMessage.add(Message.danger(msg:SECURITYSTAMP_ERROR, respite: 2));
      return;
    }
    await _service.GetToken(model);
  }
}
