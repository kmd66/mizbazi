import 'BaseModel.dart';

class CheckHost extends BaseModel{
  String? webWersion;
  String? homePage;


  CheckHost.error(Map<String, dynamic> json) : super.error(json);
  CheckHost({this.webWersion});
  CheckHost.fromJson(Map<String, dynamic> json):
        webWersion = json['webWersion'],
        homePage = json['homePage'];


  @override
  Map<String, dynamic> toJson() =>{
    'webWersion' : webWersion,
    'homePage' : homePage
  };

}