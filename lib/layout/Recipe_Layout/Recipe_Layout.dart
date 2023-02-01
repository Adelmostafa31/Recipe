import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/dbIcon.dart';
import 'package:food/shared/Cubit/cubit.dart';
import 'package:food/shared/Cubit/states.dart';
import 'package:food/shared/styles/colors.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
class Recipe_Layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipeCubit, RecipeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = RecipeCubit.get(context);
        return Scaffold(
          body: cubit.screens[cubit.currentIndexBottomNav],
          bottomNavigationBar: GNav(
            selectedIndex: cubit.currentIndexBottomNav,
            onTabChange: (index){
              cubit.ChangeBottomNav(index);
            },
            curve: Curves.fastLinearToSlowEaseIn,
            tabBackgroundColor: Colors.green.withOpacity(0.4),
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: defualtColor()
            ),
            gap: 20,
            iconSize: 22,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            activeColor: defualtColor(),
            padding: EdgeInsets.all(15),
            tabs: [
              GButton(
                icon: dbIcon.home_2,
                text: 'Home',
                iconSize: 30,
              ),
              GButton(
                icon: dbIcon.th_list_outline,
                text: 'Category',

              ),
              GButton(
                icon: Icons.bookmark_border,
                iconSize: 28,
                text: 'Saved',
              ),
              GButton(
                icon: dbIcon.settings_1,
                text: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}