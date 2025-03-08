import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/appSettings.dart';
import '../../core/appText.dart';
import '../../core/event.dart';
import '../../services/pblService.dart';
import 'constText.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _State();
}

class _State extends State<HomePage> {

  @override
  void initState() {
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
      color: Colors.deepOrange,
    );
  }
}
