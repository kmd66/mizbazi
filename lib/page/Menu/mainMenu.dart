import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:miz_bazi/core/appText.dart';
import '../../Widgets/Icon.dart';
import '../../core/appColor.dart';
import '../../core/event.dart';
import '../Home/routes.dart';

class MainMenu extends StatefulWidget {
  @override
  State<MainMenu> createState() => _State();
}

class _State extends State<MainMenu> {
  List<Widget> list = [];

  @override
  void initState() {
    setItem();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setItem() {
    list.add(item(
        lable: 'home',
        icon: Iconsax.home,
        margin:const EdgeInsets.symmetric(vertical: 5),
        onPress:()=>streamRoutes.add(ChengStateWeb(RouteType.home)),
    ));
    list.add(item(
        lable: 'coinWeb',
        icon: Iconsax.bitcoin_refresh,
        margin:const EdgeInsets.symmetric(vertical: 5),
        onPress:()=>streamRoutes.add(ChengStateWeb(RouteType.coinWeb)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: BaseColor,
      shadowColor:Colors.transparent,
      title: AppText('appBarTitle'),
    );
  }

  Widget _body(BuildContext context) {
    return
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: BackgroundColor,
        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(children:list),
          ),
        ),
      );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return
      Container(
        color: BackgroundColor,
          child: IconButton(
            icon: AppIcon(
              color: BaseColor,
              Iconsax.close_circle5,
              size: 55,
            ),
            onPressed: () {
              close();
            },
        ),
      );
  }

  Widget item({
    required String lable,
    required IconData icon,
    required EdgeInsets margin,
    required VoidCallback onPress
  }) {
    return Container(
        margin:margin,
        child: InkWell(
            onTap: (){
              close();
              onPress();
            },
            child:Column(children: [
              Container(
                margin:margin,
                padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 15),
                child: Row(children: [
                  AppIcon(icon, color: LinkColor,),
                  Container(margin: const EdgeInsets.only(left: 12.0)
                  ),
                  AppText(lable),
                ]),
              ),
              Container(
                height: 1,
                margin: EdgeInsets.only(top: 3),
                decoration: BoxDecoration(color:TextColor2,),
              ),
            ],)
        ),) ;
  }

  void close(){
    streamDialogRoutes.add(DialogRouteType.empty);
  }
}
