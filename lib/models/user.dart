import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? email;

  UserModel({this.uid, this.email});

  factory UserModel.fromSnapshot(DocumentSnapshot doc) {
    return UserModel(
      email: doc['email'],
      uid: doc['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "email": email,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      uid: json['uid'],
    );
  }
}
