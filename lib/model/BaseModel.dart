class BaseModel {

  int resultCode = 200;
  bool resultSuccess = true;
  String resultMessage = "";

  Map<String, dynamic> toJson()=>{};
  BaseModel();

  BaseModel.error(Map<String, dynamic> json){
    resultSuccess = false;
    resultCode = json['code'] != null ? json['code'] : -111;
    resultMessage = json['message'] != null ?  json['message']: "error";
  }

  Map<String, dynamic> toErrorJson() =>{'resultSuccess' : resultSuccess,'resultCode' : resultCode,'resultMessage' : resultMessage};
}