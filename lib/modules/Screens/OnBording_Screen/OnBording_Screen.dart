import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/modules/Screens/Login_Screen/Login_Screen.dart';
import 'package:food/shared/components/components.dart';
import 'package:food/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:food/shared/network/Cach_Helper/cach_helper.dart';


// ignore: camel_case_types
class onBordingModel {
  String? imagePath;
  String? title;
  String? discription;

  onBordingModel(
      {required this.title,
      required this.imagePath,
      required this.discription});
}

// ignore: camel_case_types
class onBordingScreen extends StatefulWidget {
  const onBordingScreen({super.key});

  @override
  State<onBordingScreen> createState() => _onBordingScreenState();
}

// ignore: camel_case_types
class _onBordingScreenState extends State<onBordingScreen> {
  List<onBordingModel> onBordList = [
    onBordingModel(
        discription:
            'Don\'t have the right measurement tools? Get various substituted measurement tools with videos on how to use them and get cooking! Also,get substition for ingredients you don\'t have.',
        imagePath: 'assets/image/burger.jpg',
        title: 'Simplified cooking'),
    onBordingModel(
        discription:
            'Browse the largest recipe directory in the world and find any recipe youre looking for. Search results are tailored to your location.',
        imagePath: 'assets/image/pizza.jpg',
        title: 'Search for any recipe you want'
        //
        ),
    onBordingModel(
        discription:
            'Add the items you have available and get a vast number of recipe suggestions.',
        imagePath: 'assets/image/hotDog.jpg',
        title: 'Get recipe for them in real-time'),
    onBordingModel(
        discription:
            'Get recipe suggestions based on health status and search history.',
        imagePath: 'assets/image/tacis.jpg',
        title: 'Get recipe suggestions')
  ];

  // ignore: non_constant_identifier_names
  var BordingController = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 725.h,
              child: PageView.builder(
                itemBuilder: (context, index) =>
                    buildOnBordingItem(onBordList[index]),
                scrollDirection: Axis.horizontal,
                controller: BordingController,
                itemCount: onBordList.length,
                onPageChanged: (int index) {
                  if (index == onBordList.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            SmoothPageIndicator(
                controller: BordingController,
                count: onBordList.length,
                effect: ExpandingDotsEffect(
                    dotColor: Colors.grey.withOpacity(0.5),
                    activeDotColor: defualtColor(),
                    dotHeight: 10,
                    dotWidth: 25,
                    expansionFactor: 3,
                    radius: 5,
                    spacing: 10)),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                defaultButton(
                  text: 'skip',
                  OnPressedFunction: () {
                    submit();
                  },
                  width: 100.w,
                  backgroundColor: defualtColor(),
                  height: 50.h
                ),
                defaultButton(
                    text: 'next',
                    OnPressedFunction: () {
                      if(isLast){
                        submit();
                      }else{
                        BordingController.nextPage(
                            duration: const Duration(
                                microseconds: 700
                            ),
                            curve: Curves.fastLinearToSlowEaseIn
                        );
                      }
                    },
                    width: 100,
                    backgroundColor: defualtColor(),
                    height: 50
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  void submit(){
    CachHelper.saveData(
        value: true,
        key: 'onBoarding'
    ).then((value){
      if(value){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context)=>loginScreen()
          ),
        );
      }
    });
  }
  Widget buildOnBordingItem(onBordingModel model) => Column(
        children: [
          Image(
            image: AssetImage(model.imagePath!),
            fit: BoxFit.cover,
            width: double.infinity,
            height: 500.h,
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
            model.title!,
            style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              model.discription!,
              style: TextStyle(
                fontSize: 22.sp,
              ),
            ),
          ),
        ],
      );
}
