// ignore_for_file: file_names
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food/layout/Recipe_Layout/Recipe_Layout.dart';
import 'package:food/modules/Screens/Login_Screen/Login_Screen.dart';
import 'package:food/modules/Screens/OnBording_Screen/OnBording_Screen.dart';
import 'package:food/shared/styles/colors.dart';
import 'package:food/shared/network/Cach_Helper/cach_helper.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: camel_case_types
class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

// ignore: camel_case_types
class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();
    var boarding = CachHelper.getData(key: 'onBoarding');
    var uid = CachHelper.getData(key: 'uid');
    Widget? widget;
    if (boarding != null) {
      if (uid != null) {
        widget = Recipe_Layout();
      } else {
        widget = loginScreen();
      }
    } else {
      widget = const onBordingScreen();
    }
    Timer(
        const Duration(seconds: 11),
        () => Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => widget!)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 280.h,
        ),
        Center(
          child: TweenAnimationBuilder(
              tween: Tween(begin: 1.0, end: 100.0),
              duration: const Duration(seconds: 3),
              builder: (BuildContext context, double? value, Widget? child) {
                return Text(
                  'WASFA',
                  style: TextStyle(
                      fontSize: value,
                      fontWeight: FontWeight.bold,
                      color: defualtColor()),
                );
              }),
        ),
        Center(
          child: TweenAnimationBuilder(
              tween: Tween(begin: 1.0, end: 27.0),
              duration: const Duration(seconds: 5),
              builder: (BuildContext context, double? value, Widget? child) {
                return Text(
                  'Are You Hungry...?',
                  style: TextStyle(
                      fontSize: value,
                      fontWeight: FontWeight.bold,
                      color: defualtColor()),
                );
              }),
        ),
        const Spacer(),
        Lottie.asset('assets/image/77322-food.json'),
      ],
    ));
  }
}
