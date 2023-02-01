import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/models/food_Model/food_Model.dart';
import 'package:food/models/user_Model/user_Model.dart';
import 'package:food/modules/Screens/Save_Screen/Save_Screen.dart';
import 'package:food/modules/Screens/category_screen/Category_Screen.dart';
import 'package:food/modules/Screens/home_screen/Home_Screen.dart';
import 'package:food/modules/Screens/setting_screen/Setting_Screen.dart';
import 'package:food/shared/Cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food/shared/network/Cach_Helper/cach_helper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class RecipeCubit extends Cubit<RecipeStates> {
  RecipeCubit() : super(RecipeIntialeState());

  static RecipeCubit get(context) => BlocProvider.of(context);
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  foodModel? FoodModel;
  userModel? UserModel;

  // bottom nav
  int currentIndexBottomNav = 0;

  List<Widget> screens = [
    homeScreen(),
    categoryScreen(),
    savedScreen(),
    settingScreen(),
  ];

  void ChangeBottomNav(int index) {
    currentIndexBottomNav = index;
    emit(ChangeBottomNavState());
  }

  //////////////////////////////////////

  // icon secure password
  IconData suffix = Icons.visibility_off;

  bool isSecure = true;

  void ChangeSecure() {
    isSecure = !isSecure;
    suffix = isSecure ? Icons.visibility_off : Icons.visibility;
    emit(ChangeSecureState());
  }

  //////////////////////////////////////
  // get user
  void getUser() {
    emit(getUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(CachHelper.getData(key: 'uid'))
        .get()
        .then((value) {
      UserModel = userModel.fromjson(value.data()!);
      emit(getUserSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(getUserErrorState(onError.toString()));
    });
  }

  //////////////////////////////////////
  // user login
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(LoginSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(LoginErrorState(onError.toString()));
    });
  }

  ///////////////////////////////////////
  // register user
  void userRegister({
    required String phone,
    required String name,
    required String email,
    required String password,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      CachHelper.saveData(value: value.user!.uid, key: 'uid');
      createUser(
          phone: phone,
          name: name,
          email: email,
          uid: value.user!.uid,
          image: '');
      // emit(RegisterSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(RegisterErrorState(onError.toString()));
    });
  }

//////////////////////////////////////////
  // sign in with google
  void signInWithGoogle() async {
    emit(SignInWithGoogleLoadingState());
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      CachHelper.saveData(value: value.user!.uid, key: 'uid');
      createUser(
          name: value.user!.displayName!,
          email: value.user!.email!,
          uid: value.user!.uid,
          phone: '',
          image: value.user!.photoURL!);
      // emit(SignInWithGoogleSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(SignInWithGoogleErrorState(onError.toString()));
    });
  }

//////////////////////////////////////////
// fire store data
  void createUser({
    String? phone,
    required String name,
    required String email,
    required String uid,
    required String image,
  }) {
    userModel model = userModel(
        email: email,
        phone: phone,
        name: name,
        uid: uid,
        image:
            'https://i.pinimg.com/564x/27/01/f5/2701f51da94a8f339b2149ca5d15d2a5.jpg');
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      getUser();
      // emit(createUserSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(createUserErrorState(onError.toString()));
    });
  }

  //////////////////////////////////////////////
  // get breakfast data
  List<foodModel> breakfastList = [];
  List<String> breakfastId = [];

  void getBreakfastData() {
    emit(getBreakfastDataLoadingState());
    FirebaseFirestore.instance.collection('breakfast').get().then((value) {
      breakfastList = [];
      breakfastId = [];
      value.docs.forEach((element) {
        breakfastId.add(element.id);
        breakfastList.add(foodModel.fromjson(element.data()));
        FoodModel = foodModel.fromjson(element.data());
      });
      emit(getBreakfastDataSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(getBreakfastDataErrorState());
    });
  }

  // get dessert data
  List<foodModel> dessertList = [];
  List<String> dessertId = [];

  void getDessertData() {
    emit(getDessertDataLoadingState());
    FirebaseFirestore.instance.collection('dessert').get().then((value) {
      dessertList = [];
      dessertId = [];
      value.docs.forEach((element) {
        dessertId.add(element.id);
        dessertList.add(foodModel.fromjson(element.data()));
        FoodModel = foodModel.fromjson(element.data());
      });
      emit(getDessertDataSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(getDessertDataErrorState());
    });
  }

  // get lunch data
  List<foodModel> lunchList = [];
  List<String> lunchId = [];

  void getLunchData() {
    emit(getLunchDataLoadingState());
    FirebaseFirestore.instance.collection('lunch').get().then((value) {
      lunchList = [];
      value.docs.forEach((element) {
        lunchId.add(element.id);
        lunchList.add(foodModel.fromjson(element.data()));
        FoodModel = foodModel.fromjson(element.data());
      });
      emit(getLunchDataSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(getLunchDataErrorState());
    });
  }

  // get past data
  List<foodModel> pastaList = [];
  List<String> pastaId = [];

  void getPastaData() {
    emit(getPastaDataLoadingState());
    FirebaseFirestore.instance.collection('pasta').get().then((value) {
      pastaList = [];
      pastaId = [];
      value.docs.forEach((element) {
        pastaId.add(element.id);
        pastaList.add(foodModel.fromjson(element.data()));
        FoodModel = foodModel.fromjson(element.data());
      });
      emit(getPastaDataSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(getPastaDataErrorState());
    });
  }

  // get dinner data
  List<foodModel> dinnerList = [];
  List<String> dinnerId = [];

  void getDinnerData() {
    emit(getDinnerDataLoadingState());
    FirebaseFirestore.instance.collection('dinner').get().then((value) {
      dinnerList = [];
      dinnerId = [];
      value.docs.forEach((element) {
        dinnerId.add(element.id);
        dinnerList.add(foodModel.fromjson(element.data()));
        FoodModel = foodModel.fromjson(element.data());
      });
      emit(getDinnerDataSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(getDinnerDataErrorState());
    });
  }

  // get drinks data
  List<foodModel> drinksList = [];
  List<String> drinksId = [];

  void getDrinksData() {
    emit(getDrinksDataLoadingState());
    FirebaseFirestore.instance.collection('drinks').get().then((value) {
      drinksList = [];
      drinksId = [];
      value.docs.forEach((element) {
        drinksId.add(element.id);
        drinksList.add(foodModel.fromjson(element.data()));
        FoodModel = foodModel.fromjson(element.data());
      });
      emit(getDrinksDataSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(getDrinksDataErrorState());
    });
  }

  // get sandawitch data
  List<foodModel> sandawitchList = [];
  List<String> sandawitchId = [];

  void getSandawitchData() {
    emit(getSandawitchDataLoadingState());
    FirebaseFirestore.instance.collection('sandawitch').get().then((value) {
      sandawitchList = [];
      sandawitchId = [];
      value.docs.forEach((element) {
        sandawitchId.add(element.id);
        sandawitchList.add(foodModel.fromjson(element.data()));
        FoodModel = foodModel.fromjson(element.data());
      });
      emit(getSandawitchDataSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(getSandawitchDataErrorState());
    });
  }

  // get recipe data
  List<foodModel> recipeList = [];
  List<String> recipeId = [];

  void getRecipeData() {
    emit(getRecipeDataLoadingState());
    FirebaseFirestore.instance.collection('recipe').get().then((value) {
      recipeList = [];
      recipeId = [];
      value.docs.forEach((element) {
        recipeId.add(element.id);
        recipeList.add(foodModel.fromjson(element.data()));
        FoodModel = foodModel.fromjson(element.data());
        // print(element.id);
      });
      // print(FoodModel.saved);
      emit(getRecipeDataSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(getRecipeErrorState());
    });
  }

  // change recipe favourite
  void changeRecipeFavourite(String recipeId, bool favourite) {
    favourite = !favourite;
    emit(changefavouriteLoadingState());
    FirebaseFirestore.instance
        .collection('recipe')
        .doc(recipeId)
        .update({'favourite': favourite}).then((value) {
      CachHelper.saveData(value: favourite, key: 'favourite');
      getRecipeData();
    }).catchError((onError) {
      print(onError.toString());
      emit(changefavouriteErrorState());
    });
  }

  // change lunch favourite
  void changeLunchFavourite(String recipeId, bool favourite) {
    favourite = !favourite;
    emit(changefavouriteLoadingState());
    FirebaseFirestore.instance
        .collection('lunch')
        .doc(recipeId)
        .update({'favourite': favourite}).then((value) {
      CachHelper.saveData(value: favourite, key: 'favourite');
      getLunchData();
    }).catchError((onError) {
      print(onError.toString());
      emit(changefavouriteErrorState());
    });
  }

  // change breakfast favourite
  void changeBreakfastFavourite(String recipeId, bool favourite) {
    favourite = !favourite;
    emit(changefavouriteLoadingState());
    FirebaseFirestore.instance
        .collection('breakfast')
        .doc(recipeId)
        .update({'favourite': favourite}).then((value) {
      CachHelper.saveData(value: favourite, key: 'favourite');
      getBreakfastData();
    }).catchError((onError) {
      print(onError.toString());
      emit(changefavouriteErrorState());
    });
  }

  // change dinner favourite
  void changeDinnerFavourite(String recipeId, bool favourite) {
    favourite = !favourite;
    emit(changefavouriteLoadingState());
    FirebaseFirestore.instance
        .collection('dinner')
        .doc(recipeId)
        .update({'favourite': favourite}).then((value) {
      CachHelper.saveData(value: favourite, key: 'favourite');
      getDinnerData();
    }).catchError((onError) {
      print(onError.toString());
      emit(changefavouriteErrorState());
    });
  }

  // change pasta favourite
  void changePastaFavourite(String recipeId, bool favourite) {
    favourite = !favourite;
    emit(changefavouriteLoadingState());
    FirebaseFirestore.instance
        .collection('pasta')
        .doc(recipeId)
        .update({'favourite': favourite}).then((value) {
      CachHelper.saveData(value: favourite, key: 'favourite');
      getPastaData();
    }).catchError((onError) {
      print(onError.toString());
      emit(changefavouriteErrorState());
    });
  }

  // change drinks favourite
  void changeDrinksFavourite(String recipeId, bool favourite) {
    favourite = !favourite;
    emit(changefavouriteLoadingState());
    FirebaseFirestore.instance
        .collection('drinks')
        .doc(recipeId)
        .update({'favourite': favourite}).then((value) {
      CachHelper.saveData(value: favourite, key: 'favourite');
      getDrinksData();
    }).catchError((onError) {
      print(onError.toString());
      emit(changefavouriteErrorState());
    });
  }

  // change sandawitch favourite
  void changeSandawitchFavourite(String recipeId, bool favourite) {
    favourite = !favourite;
    emit(changefavouriteLoadingState());
    FirebaseFirestore.instance
        .collection('sandawitch')
        .doc(recipeId)
        .update({'favourite': favourite}).then((value) {
      CachHelper.saveData(value: favourite, key: 'favourite');
      getSandawitchData();
    }).catchError((onError) {
      print(onError.toString());
      emit(changefavouriteErrorState());
    });
  }

  // change dessert favourite
  void changeDessertFavourite(String recipeId, bool favourite) {
    favourite = !favourite;
    emit(changefavouriteLoadingState());
    FirebaseFirestore.instance
        .collection('dessert')
        .doc(recipeId)
        .update({'favourite': favourite}).then((value) {
      CachHelper.saveData(value: favourite, key: 'favourite');
      getDessertData();
    }).catchError((onError) {
      print(onError.toString());
      emit(changefavouriteErrorState());
    });
  }

  //  set saved list
  void setSaved(String recipeId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(UserModel!.uid)
        .collection('saved')
        .doc(recipeId)
        .set(FoodModel!.toMap()!)
        .then((value) {
      getSaved();
      // emit(SavedSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(SavedErrorState());
    });
  }

  // get saved list
  List<foodModel> saveList = [];
  List<String> saveListId = [];

  void getSaved() {
    emit(getSavedLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(CachHelper.getData(key: 'uid'))
        .collection('saved')
        .get()
        .then((value) {
      saveList = [];
      saveListId = [];
      value.docs.forEach((element) {
        saveListId.add(element.id);
        saveList.add(foodModel.fromjson(element.data()));
      });
      emit(getSavedSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(getSavedErrorState());
    });
  }

  // ubdate saved list
  void ubdateRecipeSaved(String recipeId, bool saved) {
    saved = !saved;
    FirebaseFirestore.instance
        .collection('recipe')
        .doc(recipeId)
        .update({'saved': saved}).then((value) {
      // CachHelper.saveData(value: saved, key: 'saved');
      getRecipeData();
    }).catchError((onError) {
      print(onError.toString());
      emit(ubdateSavedErrorState());
    });
  }

  void ubdateSaved(String recipeId, bool saved) {
    saved = !saved;
    FirebaseFirestore.instance
        .collection('users')
        .doc(CachHelper.getData(key: 'uid'))
        .collection('saved')
        .doc(recipeId)
        .update({'saved': saved}).then((value) {
      // CachHelper.saveData(value: saved, key: 'saved');
      // emit(ubdateSavedSuccessState());
      getSaved();
    }).catchError((onError) {
      print(onError.toString());
      emit(ubdateSavedErrorState());
    });
  }

  // delete from saved list
  void deleteSaved(String recipeId, bool saved) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(CachHelper.getData(key: 'uid'))
        .collection('saved')
        .doc(recipeId)
        .delete()
        .then((value) {
      getSaved();
      ubdateRecipeSaved(recipeId, saved);
    }).catchError((onError) {
      print(onError.toString());
      emit(deleteDataErrorState());
    });
  }
  ////////////////////////////////////////////////
  // pick profile image
  File? profileImage;
  var profilePicker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickerFile =
        await profilePicker.getImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      print(pickerFile.path);
      profileImage = File(pickerFile.path);
      emit(PickedImageSuccessState());
    } else {
      print('No Image Selected');
      emit(PickedImageErrorState());
    }
  }
  ////////////////////////////////////////////////
  // upload profile image
  String profileImageUrl = '';

  void uploadProfileImage() {
    emit(UploadProfileLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        print(profileImageUrl);
        updateUserImage();
        // emit(UploadProfileSuccessState());
      }).catchError((Error) {
        print(Error.toString());
        emit(UploadProfileErrorState1());
      });
      // updateUserImage();
    }).catchError((Error) {
      print(Error.toString());
      emit(UploadProfileErrorState2());
    });
  }
  ////////////////////////////////////////////////
  // update profile image
  void updateUserImage() {
    emit(UpdateUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(CachHelper.getData(key: 'uid'))
        .update({'image': profileImageUrl}).then((value) {
      // getUser();
      emit(UpdateUserSuccessState());
    }).catchError((onError) {
      emit(UpdateUserErrorState());
    });
  }
  ////////////////////////////////////////////////
  // logout from account
  void logOut() {
    CachHelper.removeData(key: 'uid');
    emit(logOutSuccessState());
  }
  ////////////////////////////////////////////////
  // revmove account from data base
  void removeAccount() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(CachHelper.getData(key: 'uid'))
        .delete()
        .then((value) {
      CachHelper.removeData(key: 'uid');
      emit(removeAccountSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(removeAccountErrorState());
    });
  }
}