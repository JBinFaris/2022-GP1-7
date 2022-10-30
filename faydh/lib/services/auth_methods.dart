import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:faydh/models/user_model.dart' as model;

import '../utilis/utilis.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Signup  method
  Future<String> signUpUser({
    required String role,
    required String username,
    required String email,
    required String phoneNumber,
    required String password,
    String? uid,
  }) async {
    String res = "تم بنجاح";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          role.isNotEmpty ||
          phoneNumber.isNotEmpty ||
          email.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        model.User user = model.User(
          uid: cred.user!.uid,
          role: role,
          username: username,
          email: email,
          phoneNumber: phoneNumber,
        );

        await _firestore
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(user.toJson());
        return "تم بنجاح";
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == "invalid-email") {
        if (error.code == 'ERROR_EMAIL_ALREADY_IN_USE')
          res =" الرجاء إدخال بريد إلكتروني صالح";
      } else if (error.code == "weak-password") {
        res = "الرجاء إدخال كلمة مرور صالحة";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  /// Logout
  Future signOut() async {
    String res = "حصل خطأ";
    try {
      await _auth.signOut();
      res = "تم بنجاح";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
    return res;
  }

  ///Resting password:
  Future<String> resetPassword({required String email}) async {
    String res = "حصل خطأ";
    try {
      await _auth.sendPasswordResetEmail(email: email);
      res = "تم بنجاح";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
    return res;
  }

  //// Login user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "حصل خطأ";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "تم بنجاح";
      } else {
        res = "الرجاء إدخال جميع الحقول";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        res = "البريد الإلكتروني غير مسجل";
      } else {
        e.code == "wrong-password";
        {
          res = "كلمة المرور غير صحيحة";
        }
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  /////Update

  Future<String> upDateProfile({
    required String role,
    required String username,
    String? email,
    required String phoneNumber,
    String? uid,
  }) async {
    String res = "تم بنجاح";
    try {
      if (username.isNotEmpty ||
          role.isNotEmpty ||
          phoneNumber.isNotEmpty ) {
        model.User user = model.User(
          uid: FirebaseAuth.instance.currentUser!.uid,
          role: role,
          username: username,
          email: FirebaseAuth.instance.currentUser!.email.toString(),
          phoneNumber: phoneNumber,
        );

        await _firestore
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update(user.toJson());
        return "success";
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == "invalid-email") {
        res = "الرجاء إدخال بريد إلكتروني صالح";
      } else if (error.code == "weak-password") {
        res = "الرجاء إدخال كلمة مرور صالحة";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
