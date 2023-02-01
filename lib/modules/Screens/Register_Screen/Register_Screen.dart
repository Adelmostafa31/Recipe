import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/dbIcon.dart';
import 'package:food/layout/Recipe_Layout/Recipe_Layout.dart';
import 'package:food/modules/Screens/Login_Screen/Login_Screen.dart';
import 'package:food/shared/components/components.dart';
import 'package:food/shared/styles/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/shared/Cubit/cubit.dart';
import 'package:food/shared/Cubit/states.dart';

// ignore: camel_case_types, must_be_immutable
class registerScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  registerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipeCubit, RecipeStates>(
      listener: (context, state) {
        if(state is RegisterErrorState){
          ShowToast(message: state.ErrorMessage, state: ToastStates.ERORR);
        }
        if(state is getUserSuccessState){
          ShowToast(message: 'Register Success', state: ToastStates.SUCCESS);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context)=> Recipe_Layout())
          );
        }
      },
      builder: (context, state) {
        var cubit = RecipeCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 50),
                      child: Text(
                        'register'.toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 60.sp,
                            color: defualtColor()),
                      ),
                    ),
                    Container(
                      clipBehavior: Clip.antiAlias,
                      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20,),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius:const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(0),
                          )),
                      child: defaultFormField(
                        type: TextInputType.text,
                        hint: 'Name',
                        controller: nameController,
                        prefix: dbIcon.person_1,
                        iconColor: Colors.green.withOpacity(0.6),
                        Validatorfunction: (String? value){
                          if(value!.isEmpty){
                            return 'This Feild Must Not Be Embty';
                          }
                          return null;
                        }
                      ),
                    ),
                    Container(
                      clipBehavior: Clip.antiAlias,
                      margin: const EdgeInsets.only(bottom: 20, right: 50,left: 50 ),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius:const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(0),
                          )),
                      child: defaultFormField(
                        type: TextInputType.phone,
                        hint: 'Phone',
                        controller: phoneController,
                        prefix: dbIcon.phone_2,
                        iconColor: Colors.green.withOpacity(0.6),
                          Validatorfunction: (String? value){
                            if(value!.isEmpty){
                              return 'This Feild Must Not Be Embty';
                            }
                            return null;
                          }
                      ),
                    ),
                    Container(
                      clipBehavior: Clip.antiAlias,
                      margin: const EdgeInsets.only(bottom: 20, right: 50,left: 50 ),
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
                        hint: 'Email',
                        controller: emailController,
                        prefix: dbIcon.mail,
                        iconColor: Colors.green.withOpacity(0.6),
                          Validatorfunction: (String? value){
                            if(value!.isEmpty){
                              return 'This Feild Must Not Be Embty';
                            }
                            return null;
                          }
                      ),
                    ),
                    Container(
                      clipBehavior: Clip.antiAlias,
                      margin:const EdgeInsets.only(bottom: 20, right: 50,left: 50 ),
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
                          Validatorfunction: (String? value){
                            if(value!.isEmpty){
                              return 'This Feild Must Not Be Embty';
                            }
                            return null;
                          }
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child:state is! RegisterLoadingState
                      ? defaultButton(
                          text: 'register',
                          topRightBorder: 10,
                          bottomLeftBorder: 0,
                          bottomRightBorder: 10,
                          topLeftBorder: 10,
                          backgroundColor: defualtColor(),
                          OnPressedFunction: () {
                            if(formKey.currentState!.validate()){
                              cubit.userRegister(
                                  phone: phoneController.text,
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                            }
                          })
                          : const Center(child: CircularProgressIndicator()),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => loginScreen()));
                          },
                          child: Text(
                            'you have an account already..?'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 22.sp, fontWeight: FontWeight.bold),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
