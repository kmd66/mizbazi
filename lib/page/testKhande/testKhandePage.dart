import 'package:flutter/material.dart';

import '../../Widgets/btns.dart';
import '../../core/appColor.dart';
import '../../core/event.dart';

class TestKhandePage extends StatefulWidget {
  @override
  State<TestKhandePage> createState() => _State();
}

class _State extends State<TestKhandePage> {

  void initState() {
    streamMainBar.add(MainBarType.all);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: AppBtn(
                  text: 'SELECT_IMG',
                  onPress: () {

                  },
                ),
              ),
              AppBtn(
                color: SuccessColor,
                text: 'SEND',
                onPress: () {

                },
              ),
              AppBtn(
                color: TextColor2,
                text: 'CANCEL',
                onPress: () {

                },
              ),
            ]
        )
    );
  }
}
