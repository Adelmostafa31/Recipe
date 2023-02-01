import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/models/food_Model/food_Model.dart';
import 'package:food/modules/Details_Screens/RecipeDetails_Screen/RecipeDetails_Screen.dart';
import 'package:food/shared/Cubit/cubit.dart';
import 'package:food/shared/Cubit/states.dart';
import 'package:food/shared/styles/colors.dart';

// ignore: camel_case_types
class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipeCubit, RecipeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = RecipeCubit.get(context);
        return Scaffold(
            body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Text(
                    'Wasfa',
                    style: TextStyle(
                      fontSize: 50.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'All You Need When You Are Hungry Is Here.',
                  style: TextStyle(
                      fontSize: 45.sp,
                      fontWeight: FontWeight.w600,
                      color: defualtColor()),
                ),
                SizedBox(
                  height: 30.h,
                ),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RecipeDetails(
                                        model: cubit.recipeList,
                                        index: index,
                                      )));
                        },
                        child: RecipeItem(
                            cubit.recipeList[index], context, index));
                  },
                  itemCount: cubit.recipeList.length,
                  separatorBuilder: (context, index) => SizedBox(
                    height: 20.h,
                  ),
                ),
              ],
            ),
          ),
        ));
      },
    );
  }

  // ignore: non_constant_identifier_names
  Widget RecipeItem(foodModel model, context, index) {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.topCenter,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Image(
                  image: NetworkImage(model.imagePath!),
                  fit: BoxFit.cover,
                  height: 500.h,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () {
                        if(model.saved == true){
                          RecipeCubit.get(context).deleteSaved(RecipeCubit.get(context).recipeId[index],model.saved!);
                        }else{
                          RecipeCubit.get(context).ubdateRecipeSaved(RecipeCubit.get(context).recipeId[index], model.saved!);
                          RecipeCubit.get(context).setSaved(RecipeCubit.get(context).recipeId[index]);
                          RecipeCubit.get(context).ubdateSaved(RecipeCubit.get(context).recipeId[index], model.saved!);
                        }
                      },
                      icon: model.saved!
                          ? Icon(
                              Icons.bookmark,
                              size: 35,
                              color: defualtColor(),
                            )
                          : Icon(
                              Icons.bookmark_border_outlined,
                              size: 35,
                              color: defualtColor(),
                            )),
                )
              ],
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
                  child: Text(
                    model.title!,
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(
                  width: 22.w,
                ),
                IconButton(
                    onPressed: () {
                      RecipeCubit.get(context).changeRecipeFavourite(
                          RecipeCubit.get(context).recipeId[index],
                          model.favourite!);
                    },
                    icon: model.favourite!
                        ? const Icon(
                            Icons.favorite_rounded,
                            size: 40,
                            color: Colors.red,
                          )
                        : const Icon(Icons.favorite_outline_outlined,
                            size: 40, color: Colors.red))
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
