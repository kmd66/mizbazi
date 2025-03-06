import 'BaseModel.dart';

class CheckHost extends BaseModel{
  String? webWersion;


  CheckHost.error(Map<String, dynamic> json) : super.error(json);
  CheckHost({this.webWersion});
  CheckHost.fromJson(Map<String, dynamic> json):webWersion = json['webWersion'];


  @override
  Map<String, dynamic> toJson() =>{'webWersion' : webWersion};

}