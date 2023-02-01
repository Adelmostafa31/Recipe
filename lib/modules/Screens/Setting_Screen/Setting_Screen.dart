import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/dbIcon.dart';
import 'package:food/models/user_Model/user_Model.dart';
import 'package:food/modules/Screens/Login_Screen/Login_Screen.dart';
import 'package:food/modules/Screens/OnBording_Screen/OnBording_Screen.dart';
import 'package:food/shared/Cubit/cubit.dart';
import 'package:food/shared/Cubit/states.dart';
import 'package:food/shared/components/components.dart';
import 'package:food/shared/styles/colors.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// ignore: camel_case_types, must_be_immutable
class settingScreen extends StatelessWidget {
  // ignore: non_constant_identifier_names
  late userModel? UserModel;

  settingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipeCubit, RecipeStates>(
      listener: (context, state) {
        if(state is logOutSuccessState){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context)=>loginScreen()
              ));
        }else if(state is removeAccountSuccessState){
          ShowToast(message: 'You Email Removed', state: ToastStates.SUCCESS);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>onBordingScreen()));
        }else if(state is removeAccountErrorState){
          ShowToast(message: 'Error In Removed Account', state: ToastStates.ERORR);
        }
      },
      builder: (context, state) {
        var userImage = RecipeCubit.get(context).profileImage;
        var user = RecipeCubit.get(context).UserModel;
        var cubit = RecipeCubit.get(context);
        Size size = MediaQuery.of(context).size;
        return Scaffold(
          body: SlidingUpPanel(
            maxHeight: (size.height / 2.4),
            minHeight: (size.height / 2.4),
            borderRadius:const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            parallaxEnabled: true,
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: ClipRRect(
                      borderRadius:const BorderRadius.only(
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Image(
                            image: userImage == null ? NetworkImage(user!.image!) : FileImage(userImage) as ImageProvider,
                            fit: BoxFit.cover,
                            height: (size.height / 2) + 120,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 50.0,right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                onPressed: (){
                                  cubit.getProfileImage();
                                },
                                icon: Icon(dbIcon.camera_3,size: 35,color: defualtColor(),)
                                ),
                                if(state is PickedImageSuccessState)
                                  TextButton(
                                    onPressed: (){
                                      cubit.uploadProfileImage();
                                    },
                                    child: Text(
                                      'Upload Image',
                                      style: TextStyle(
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.bold
                                      ),
                                    )
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            panel: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 7.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: defualtColor()),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                      child: Text(
                          'User Details',
                          style:
                          TextStyle(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold,
                            color: defualtColor()
                          )
                      )
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    '- Name :  ${user!.name!}',
                    style: TextStyle(fontSize: 35.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text('- Email :  ${user.email!}',
                      style:
                          TextStyle(fontSize: 27.sp, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10.h,
                  ),
                  if(user.phone != '')
                    Text('- Phone :  ${user.phone!}',
                      style:
                          TextStyle(fontSize: 25.h, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  defaultButton(
                    text: 'Logout',
                    topRightBorder: 15,
                    topLeftBorder: 15,
                    bottomRightBorder: 15,
                    bottomLeftBorder: 0,
                    backgroundColor: defualtColor(),
                    OnPressedFunction: (){
                      cubit.logOut();
                    },
                  ),
                  SizedBox(height: 10.h,),
                  defaultButton(
                    text: 'remove account',
                    topRightBorder: 15,
                    topLeftBorder: 15,
                    bottomRightBorder: 15,
                    bottomLeftBorder: 0,
                    backgroundColor: defualtColor(),
                    OnPressedFunction: (){
                      cubit.removeAccount();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
