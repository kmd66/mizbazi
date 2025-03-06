import 'BaseModel.dart';

class SendSecurityStampDto extends BaseModel{
  String? phone;
  String? stamp;

  SendSecurityStampDto.error(Map<String, dynamic> json) : super.error(json);
  SendSecurityStampDto({this.phone, this.stamp});
  SendSecurityStampDto.fromJson(Map<String, dynamic> json):phone = json['phone'], stamp = json['stamp'];

  @override
  Map<String, dynamic> toJson() =>{'phone' : phone,'stamp' : stamp};
}
