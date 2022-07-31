import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_template/models/user.dart';
import 'package:get/get.dart';

class UserService {
  static final _collection = FirebaseFirestore.instance.collection('users');

  static Future<UserModel?> createUser(String uid, UserModel user) async {
    try {
      final docRef = _collection.doc(uid);
      docRef.set({
        'email': user.email,
        'uid': user.uid,
      });
      Get.snackbar('Authentication', ' User created');

      final snapShot = await _collection.doc(uid).get();
      return UserModel.fromSnapshot(snapShot);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  static Future<UserModel?> getUser(String uid) async {
    try {
      final DocumentSnapshot snapShot = await _collection.doc(uid).get();
      if (!snapShot.exists) {
        throw FirebaseAuthException(
          code: 'Firebase Auth Exception',
          message: 'Not found User',
        );
      }
      return UserModel.fromSnapshot(snapShot);
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
