import 'dart:convert';
import 'dart:typed_data';
import 'package:miz_bazi/core/appSettings.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:miz_bazi/services/UserService.dart';
import 'package:miz_bazi/services/uploadService.dart';
import '../../Widgets/Btn.dart';
import '../../core/appColor.dart';
import '../../core/appText.dart';
import '../../core/event.dart';
import '../../model/Message.dart';
import 'constText.dart';

enum _registerStateType {
  empty,
  avatarSelect,
  avatarUpload,
  user,
}

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _State();
}

class _State extends State<Register> {
  final ImagePicker _picker = ImagePicker();
  var _registerState = _registerStateType.empty;
  Uint8List? _image;
  String? _imageName;
  String? _mimeType;
  final _userService = UserService();
  final _uploadService = UploadService();

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    setState(() {
      if(AppStrings.userAvatar != null){
        _registerState = _registerStateType.user;
      }
      else {
        _registerState = _registerStateType.avatarSelect;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_registerState == _registerStateType.empty) {
      return Container(width: 0,height: 0,);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 20),
      child: _registerState == _registerStateType.avatarSelect ? selectAvatar(context):
      (_registerState == _registerStateType.avatarUpload ? uploadAvatar(context) : insertUser(context)),
    );
  }

  Widget selectAvatar(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: AppText(SELECT_IMG_COMMENT),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: AppBtn(
            text: SELECT_IMG,
            onPressed: ()=> selectImg(),
          ),
        ),
      ],
    );
  }

  Widget uploadAvatar(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Image.memory(
            _image!,
            height: 300,
            width: 200,
            fit: BoxFit.fill,
          ),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppBtn(
                color: SuccessColor,
                text: UPLOAD_IMG,
                onPressed: ()=>uploadImg(),
              ),
              AppBtn(
                color: TextColor2,
                text: CANCEL,
                onPressed: ()=> setState(()=>_registerState = _registerStateType.avatarSelect),
              ),
            ]
        )
      ],
    );
  }

  Widget insertUser(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.deepOrange,
      child: Image.memory(
        base64Decode(AppStrings.userAvatar!),
        height: 300,
        width: 200,
        fit: BoxFit.fill,
      ),
    );
  }

  void selectImg() async{
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {

      final fileExtension = path.extension(image.name).toLowerCase();
      if (fileExtension != '.jpeg' && fileExtension != '.jpg') {
        streamMessage.add(Message.danger(msg:SELECT_IMG_ERROR1, respite: 2));
        return;
      }
      var imageBytes = await image.readAsBytes();

      if(imageBytes.length > 5232880){
        streamMessage.add(Message.danger(msg:SELECT_IMG_ERROR2, respite: 2));
      }

      _image  = imageBytes ;
      _imageName = image.name;
      _mimeType =image.mimeType;
      setState(()=>_registerState = _registerStateType.avatarUpload);
    }
  }

  void uploadImg() async {
    final fileExtension = path.extension(_imageName!).toLowerCase();
    var result = await _uploadService.Avatar(_image!, fileExtension, _mimeType! );
    if (result) {
      await _userService.GetAvatar();
      load();
    }
  }

}
