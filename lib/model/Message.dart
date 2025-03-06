import '../core/appColor.dart';

class Message{
  MessageType type ;
  int respite ;
  String title;
  String msg;
  String btnTitle ;
  String btnExitTitle ;
  bool exit;
  Function()? onOk;

  Message({
    this.btnTitle = 'حله', this.btnExitTitle = 'انصراف', this.exit = false, this.respite = 0,this.title = 'پیام',this.msg = '', this.onOk,
  }):type= MessageType.Danger;

  Message.danger({
    this.btnTitle = 'حله', this.btnExitTitle = 'انصراف', this.exit = false,this.respite = 0,this.title = 'خطا', this.msg = '', this.onOk,
  }):type= MessageType.Danger;
  Message.warning({
    this.btnTitle = 'حله', this.btnExitTitle = 'انصراف', this.exit = false,this.respite = 0,this.title = 'هشدار', this.msg = '', this.onOk,
  }):type= MessageType.Warning;
  Message.info({
    this.btnTitle = 'حله', this.btnExitTitle = 'انصراف', this.exit = false,this.respite = 0,this.title = 'پیام', this.msg = '', this.onOk,
  }):type= MessageType.Info;
}
