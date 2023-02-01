abstract class RecipeStates {}

class RecipeIntialeState extends RecipeStates {}

class ChangeBottomNavState extends RecipeStates {}

class ChangeSecureState extends RecipeStates {}

class LoginLoadingState extends RecipeStates{}

class LoginSuccessState extends RecipeStates{}

class LoginErrorState extends RecipeStates{
  final String ErrorMessage;

  LoginErrorState(this.ErrorMessage);
}

class logOutSuccessState extends RecipeStates{}

class RegisterLoadingState extends RecipeStates{}

class RegisterSuccessState extends RecipeStates{}

class RegisterErrorState extends RecipeStates{
  final String ErrorMessage;
  RegisterErrorState(this.ErrorMessage);
}
class removeAccountSuccessState extends RecipeStates{}

class removeAccountErrorState extends RecipeStates{}

class getUserLoadingState extends RecipeStates{}

class getUserSuccessState extends RecipeStates{}

class getUserErrorState extends RecipeStates{
  final String ErrorMessage;
  getUserErrorState(this.ErrorMessage);
}

class SignInWithGoogleLoadingState extends RecipeStates{}

class SignInWithGoogleSuccessState extends RecipeStates{}

class SignInWithGoogleErrorState extends RecipeStates{
  final String ErrorMessage;
  SignInWithGoogleErrorState(this.ErrorMessage);
}

class createUserSuccessState extends RecipeStates{}

class createUserErrorState extends RecipeStates{
  final String ErrorMessage;
  createUserErrorState(this.ErrorMessage);
}

class getBreakfastDataLoadingState extends RecipeStates{}

class getBreakfastDataSuccessState extends RecipeStates{}

class getBreakfastDataErrorState extends RecipeStates{}

class getDessertDataLoadingState extends RecipeStates{}

class getDessertDataSuccessState extends RecipeStates{}

class getDessertDataErrorState extends RecipeStates{}

class getDinnerDataLoadingState extends RecipeStates{}

class getDinnerDataSuccessState extends RecipeStates{}

class getDinnerDataErrorState extends RecipeStates{}

class getLunchDataLoadingState extends RecipeStates{}

class getLunchDataSuccessState extends RecipeStates{}

class getLunchDataErrorState extends RecipeStates{}

class getDrinksDataLoadingState extends RecipeStates{}

class getDrinksDataSuccessState extends RecipeStates{}

class getDrinksDataErrorState extends RecipeStates{}

class getPastaDataLoadingState extends RecipeStates{}

class getPastaDataSuccessState extends RecipeStates{}

class getPastaDataErrorState extends RecipeStates{}

class getSandawitchDataLoadingState extends RecipeStates{}

class getSandawitchDataSuccessState extends RecipeStates{}

class getSandawitchDataErrorState extends RecipeStates{}

class getRecipeDataLoadingState extends RecipeStates{}

class getRecipeDataSuccessState extends RecipeStates{}

class getRecipeErrorState extends RecipeStates{}

class changefavouriteLoadingState extends RecipeStates{}

class changefavouriteErrorState extends RecipeStates{}

class SavedSuccessState extends RecipeStates{}

class SavedErrorState extends RecipeStates{}

class getSavedLoadingState extends RecipeStates{}

class getSavedSuccessState extends RecipeStates{}

class getSavedErrorState extends RecipeStates{}

class ubdateSavedErrorState extends RecipeStates{}

class ubdateSavedSuccessState extends RecipeStates{}

class deleteDataSuccessState extends RecipeStates{}

class deleteDataErrorState extends RecipeStates{}

class PickedImageSuccessState extends RecipeStates{}

class PickedImageErrorState extends RecipeStates{}

class UploadProfileLoadingState extends RecipeStates{}

class UploadProfileSuccessState extends RecipeStates{}

class UploadProfileErrorState1 extends RecipeStates{}

class UploadProfileErrorState2 extends RecipeStates{}

class UpdateUserLoadingState extends RecipeStates{}

class UpdateUserSuccessState extends RecipeStates{}

class UpdateUserErrorState extends RecipeStates{}




