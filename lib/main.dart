import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/modules/Screens/Splash_Screen/Splash_Screen.dart';
import 'package:food/shared/Cubit/cubit.dart';
import 'package:food/shared/Cubit/states.dart';
import 'package:food/shared/bloc_observer.dart';
import 'package:food/shared/styles/themes/ThemeData.dart';
import 'package:food/shared/network/Cach_Helper/cach_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CachHelper.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RecipeCubit()
        ..getUser()
        ..getRecipeData()
        ..getBreakfastData()
        ..getDessertData()
        ..getDinnerData()
        ..getDrinksData()
        ..getLunchData()
        ..getPastaData()
        ..getSandawitchData()
        ..getSaved(),
      child: BlocConsumer<RecipeCubit, RecipeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (BuildContext context, Widget? child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: LightTheme,
                home: const splashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
