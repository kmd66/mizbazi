import 'package:flutter/material.dart';

import '../../core/appColor.dart';
import '../../core/appText.dart';
import '../../core/event.dart';
import 'constText.dart';

class Reconnect extends StatelessWidget {
  Reconnect(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return
      Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppText(CONNECTION_PROBLEM,fontSize:28),
          Padding(
            padding: const EdgeInsets.all( 30),
            child: AppText(CONNECTION_PROBLEM_COMMENT,fontSize:14, textAlign: TextAlign.center),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: ()
            => chengStateMain.add(ChengState(StateType.splash)),
            child: AppText(RECONNECT,fontSize:14),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: AppText(text,fontSize:10, textAlign: TextAlign.center,color: TextColor2,),
          ),

        ],
      ));

  }

}
