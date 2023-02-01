

// import 'dart:html';



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton({
  double width = double.infinity,
  double height = 50,
  Color backgroundColor = Colors.red,
  double topRightBorder = 25,
  double bottomLeftBorder = 25,
  double bottomRightBorder = 25,
  double topLeftBorder = 25,
  required String text,
  required OnPressedFunction,
  double fontsize = 25,
}) =>
    Container(
      height: height,
      width: width,
      child: MaterialButton(
        onPressed: OnPressedFunction,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            fontSize: fontsize,
            color: Colors.white.withOpacity(0.8),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(topRightBorder),
          bottomLeft: Radius.circular(bottomLeftBorder),
          bottomRight: Radius.circular(bottomRightBorder),
          topLeft: Radius.circular(topLeftBorder),
        ),
        color: backgroundColor,
      ),
    );
///////////////////////////////////
Widget defaultFormField(
        {required TextInputType type,
        required String hint,
        IconData? prefix,
        IconData? suffix,
        required TextEditingController controller,
        Validatorfunction,
        suffixPressedFunction,
        bool isScure = false,
        iconColor
        }) =>
    Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      child: TextFormField(
          style: TextStyle(
              fontSize: 30,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.bold,
          ),
          controller: controller,
          keyboardType: type,
          validator: Validatorfunction,
          obscureText: isScure,
          toolbarOptions: ToolbarOptions(
            copy: true,
            paste: true,
            selectAll: true,
            cut: true
          ),
          decoration: InputDecoration(
            prefix: Padding(
              padding: const EdgeInsets.only(right: 15,left: 15),
              child: Icon(prefix, color: iconColor),
            ),
            suffix: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: IconButton(
                  onPressed: suffixPressedFunction,
                  icon: Icon(
                    suffix,
                    color: iconColor,
                  )),
            ),
            hintText: hint,
            hintStyle: TextStyle(fontSize: 30,),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )
            )
          )),
    );
//////////////////////////////////////
void ShowToast({
  required String message,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ChooseToastState(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERORR, WARNING }

Color ChooseToastState(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERORR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
/////////////////////////////////////////////////
// void SignOut(context){
//   CachHelper.removeData(key:'token').then((value){
//     if(value){
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context)=>Login_Screen())
//         );
//       }
//   });
// }
