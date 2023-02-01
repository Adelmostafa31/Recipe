class foodModel {
  String? title;
  String? discription;
  String? imagePath;
  List<dynamic> recipe = [];
  bool? favourite;
  bool? saved;

  foodModel(
      {required this.favourite,
      required this.saved,
      required this.title,
      required this.discription,
      required this.imagePath,
      required this.recipe});

  foodModel.fromjson(Map<String, dynamic> json) {
    title = json['title'];
    discription = json['discription'];
    imagePath = json['imagePath'];
    favourite = json['favourite'];
    saved = json['saved'];
    recipe = json['recipe'];
  }

  Map<String, dynamic?>? toMap() {
    return {
      'title': title,
      'discription': discription,
      'imagePath': imagePath,
      'favourite': favourite,
      'saved': saved,
      'recipe': recipe,
    };
  }
}
