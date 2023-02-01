import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/dbIcon.dart';
import 'package:food/models/food_Model/food_Model.dart';
import 'package:food/shared/Cubit/cubit.dart';
import 'package:food/shared/Cubit/states.dart';
import 'package:food/shared/styles/colors.dart';
import 'package:lottie/lottie.dart';

// ignore: camel_case_types
class savedScreen extends StatelessWidget {
  const savedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipeCubit, RecipeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = RecipeCubit.get(context);
        return cubit.saveList.length > 0
            ? Scaffold(
            body: SingleChildScrollView(
              physics:const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Padding(
                padding:
                const EdgeInsets.only(right: 25.0, left: 25, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return savedItem(
                            cubit.recipeList[index], context, index);
                      },
                      itemCount: cubit.saveList.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(
                            height: 20.h,
                          ),
                    ),
                  ],
                ),
              ),
            ))
            : Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/image/4762-food-carousel.json',
                  height: 200.h, width: 200.w, fit: BoxFit.cover),
              SizedBox(
                height: 10.h,
              ),
              TweenAnimationBuilder(
                  tween: Tween(begin: 1.0, end: 39.0),
                  duration: const Duration(seconds: 2),
                  builder: (BuildContext context, double? value,
                      Widget? child) {
                    return Text(
                      'There Is No Saves Item',
                      style: TextStyle(
                          fontSize: value,
                          fontWeight: FontWeight.bold,
                          color: defualtColor()),
                    );
                  }),
            ],
          ),
        );
      },
    );
  }

  Widget savedItem(foodModel model, context, index) {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.topCenter,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration:const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Image(
              image: NetworkImage(model.imagePath!),
              fit: BoxFit.cover,
              height: 500.h,
              width: double.infinity,
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        model.title!,
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            RecipeCubit.get(context).deleteSaved(
                                RecipeCubit
                                    .get(context)
                                    .saveListId[index],
                                model.saved!);
                          },
                          icon: const Icon(
                            dbIcon.trash_2,
                            size: 30,
                          ))
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              model.discription!,
              style: TextStyle(
                fontSize: 22.sp,
              ),
            ),
          ],
        )
      ],
    );
  }
}
