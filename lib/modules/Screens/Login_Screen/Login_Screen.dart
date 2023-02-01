import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/dbIcon.dart';
import 'package:food/layout/Recipe_Layout/Recipe_Layout.dart';
import 'package:food/modules/Screens/Register_Screen/Register_Screen.dart';
import 'package:food/shared/Cubit/cubit.dart';
import 'package:food/shared/Cubit/states.dart';
import 'package:food/shared/components/components.dart';
import 'package:food/shared/styles/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: camel_case_types, must_be_immutable
class loginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  loginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipeCubit, RecipeStates>(
      listener: (context, state) {
        if (state is getUserSuccessState) {
          ShowToast(
              message: 'Sign In With Google Success',
              state: ToastStates.SUCCESS);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => Recipe_Layout()));
        } else if (state is LoginSuccessState) {
          ShowToast(message: 'Login Success', state: ToastStates.SUCCESS);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => Recipe_Layout()));
        } else if (state is SignInWithGoogleErrorState) {
          ShowToast(message: state.ErrorMessage, state: ToastStates.ERORR);
        } else if (state is LoginErrorState) {
          ShowToast(message: state.ErrorMessage, state: ToastStates.ERORR);
        }
      },
      builder: (context, state) {
        var cubit = RecipeCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CarouselSlider(
                      items: const [
                        Image(
                          image: AssetImage('assets/image/donate_carusal.jpg'),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                        Image(
                          image: AssetImage('assets/image/coruaso_carusal.jpg'),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                        Image(
                          image: AssetImage('assets/image/hotdog_carusal.jpg'),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                        Image(
                          image: AssetImage('assets/image/meat_carusal.jpg'),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                        Image(
                          image:
                              AssetImage('assets/image/sandawitch_carusal.jpg'),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ],
                      options: CarouselOptions(
                        height: 320.h,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval:const Duration(seconds: 2),
                        autoPlayAnimationDuration:const Duration(seconds: 1),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                        viewportFraction: 1.0,
                      )),
                  Container(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(0),
                        )),
                    child: defaultFormField(
                        type: TextInputType.emailAddress,
                        hint: 'Email',
                        controller: emailController,
                        prefix: dbIcon.mail,
                        iconColor: Colors.green.withOpacity(0.6),
                        Validatorfunction: (String? value) {
                          if (value!.isEmpty) {
                            return 'This Feild Must Not Be Embty';
                          }
                          return null;
                        }),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.only(bottom: 20, right: 50, left: 50),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius:const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(0),
                        )),
                    child: defaultFormField(
                        type: TextInputType.emailAddress,
                        hint: 'Password',
                        controller: passwordController,
                        isScure: cubit.isSecure,
                        suffix: cubit.suffix,
                        prefix: dbIcon.lock_3,
                        suffixPressedFunction: () {
                          cubit.ChangeSecure();
                        },
                        iconColor: Colors.green.withOpacity(0.6),
                        Validatorfunction: (String? value) {
                          if (value!.isEmpty) {
                            return 'This Feild Must Not Be Embty';
                          }
                          return null;
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: state is! LoginLoadingState
                        ? defaultButton(
                            text: 'login',
                            topRightBorder: 10,
                            bottomLeftBorder: 0,
                            bottomRightBorder: 10,
                            topLeftBorder: 10,
                            backgroundColor: defualtColor(),
                            OnPressedFunction: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            })
                        :const Center(child: CircularProgressIndicator()),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Row(
                      children: [
                        Text(
                          'you don\'t have an account..?'.toUpperCase(),
                          style: TextStyle(fontSize: 18.sp, color: defualtColor()),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => registerScreen()));
                            },
                            child: Text(
                              'register'.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 20.sp, fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ),
                  Text(
                    'Or..',
                    style: TextStyle(
                        fontSize: 30.sp,
                        color: defualtColor(),
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: OutlinedButton(
                      onPressed: () {
                        if (state is! SignInWithGoogleLoadingState) {
                          cubit.signInWithGoogle();
                        } else {
                          const Center(child: CircularProgressIndicator());
                        }
                      },
                      clipBehavior: Clip.antiAlias,
                      child: Row(
                        children:[
                          Image(
                            image: const AssetImage('assets/image/google logo.jpg'),
                            fit: BoxFit.cover,
                            height: 50.h,
                            width: 40.w
                            ,
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Text(
                            'Sign In With Google Account',
                            style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w900,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
