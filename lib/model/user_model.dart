class UserModel {
  String? uid;
  String? email;
  String? restaurantName;
  String? restaurantUserName;

  UserModel({this.uid, this.email, this.restaurantName, this.restaurantUserName});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      restaurantName: map['restaurantName'],
      restaurantUserName: map['restaurantUserName'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'restaurantName': restaurantName,
      'restaurantUserName': restaurantUserName,
    };
  }
}