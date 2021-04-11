import 'package:flutter/cupertino.dart';

class User {
  String phoneNo;
  String name ;
  ImageProvider imageUrl = AssetImage('Assets/Images/30916342.jpg');
  String status = "";

  User({
    this.phoneNo,
    this.name = "Full name",
    this.imageUrl,
    this.status = "Hey There!",
  });
}

User currentUser = new User();
