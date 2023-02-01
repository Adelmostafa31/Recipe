// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/modules/Screens/Breakfast_Screen/Breakfast_Screen.dart';
import 'package:food/modules/Screens/Dessert_Screen/Dessert_Screen.dart';
import 'package:food/modules/Screens/Dinner_Screen/Dinner_Screen.dart';
import 'package:food/modules/Screens/Lunch_Screen/Lunch_Screen.dart';
import 'package:food/modules/Screens/Pasta_Screen/Pasta_Screen.dart';
import 'package:food/modules/Screens/Sandawitch_Screen/Sandawitch_Screen.dart';
import 'package:food/modules/Screens/drinks_screen/drinks_screen.dart';
import 'package:food/shared/styles/colors.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

// ignore: camel_case_types
class categoryScreen extends StatelessWidget {
  const categoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: 7,
          initialIndex: 0,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(
                        text: 'Breakfast'.toUpperCase(),
                      ),
                      Tab(
                        text: 'Lunch'.toUpperCase(),
                      ),
                      Tab(
                        text: 'dinner'.toUpperCase(),
                      ),
                      Tab(
                        text: 'pasta'.toUpperCase(),
                      ),
                      Tab(
                        text: 'sandawitchs'.toUpperCase(),
                      ),
                      Tab(
                        text: 'dessert'.toUpperCase(),
                      ),
                      Tab(
                        text: 'drinks'.toUpperCase(),
                      ),
                    ],
                    labelColor: defualtColor(),
                    labelStyle:
                        const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    indicator: RectangularIndicator(
                        color: Colors.green.withOpacity(0.4),
                        bottomLeftRadius: 20,
                        bottomRightRadius: 20,
                        topLeftRadius: 20,
                        topRightRadius: 20,
                        strokeWidth: 7),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const Expanded(
                    child:  TabBarView(children: [
                      breakfastScreen(),
                      lunchScreen(),
                      dinnerScreen(),
                      pastaScreen(),
                      sandawitchScreen(),
                      dessertScreen(),
                      drinksScreen()
                    ]),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
