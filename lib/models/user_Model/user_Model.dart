class userModel {
  String? name;
  String? email;
  String? phone;
  String? uid;
  String? image;

  userModel({
    required this.email,
    required this.phone,
    required this.name,
    required this.uid,
    required this.image
  });

  userModel.fromjson(Map<String, dynamic> json){
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uid = json['uid'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name' : name,
      'email': email,
      'phone': phone,
      'uid': uid,
      'image':image
    };
  }
}