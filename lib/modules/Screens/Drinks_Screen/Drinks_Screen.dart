// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/models/food_Model/food_Model.dart';
import 'package:food/modules/Details_Screens/DrinksDetails_Screen/DrinksDetails_Screen.dart';
import 'package:food/shared/Cubit/cubit.dart';
import 'package:food/shared/Cubit/states.dart';
class drinksScreen extends StatelessWidget {
  const drinksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipeCubit,RecipeStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = RecipeCubit.get(context);
        return Scaffold(
            body: SingleChildScrollView(
              physics:const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListView.separated(
                      physics:const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context)=>DrinksDetails(model:cubit.drinksList,index: index,))
                              );
                            } ,
                            child: DrinkItem(cubit.drinksList[index],context,index)
                        );
                      },
                      itemCount: cubit.drinksList.length,
                      separatorBuilder: (context, index) => SizedBox(height: 20.h,),
                    ),
                  ],
                ),
              ),
            )
        );
      },
    );
  }
  // ignore: non_constant_identifier_names
  Widget DrinkItem(foodModel model ,context,index) {
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
        SizedBox(height:10.h,),
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
                SizedBox(width: 22.w,),
                IconButton(
                    onPressed: (){
                      RecipeCubit.get(context).changeDrinksFavourite(
                          RecipeCubit.get(context).drinksId[index],
                          model.favourite!
                      );
                    },
                    icon: model.favourite!
                        ? const Icon(Icons.favorite_rounded,size: 40,color: Colors.red,)
                        : const Icon(Icons.favorite_outline_outlined,size: 40,color: Colors.red)
                )
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
