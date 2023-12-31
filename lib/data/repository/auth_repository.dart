import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:otonomus/data/models/user_model.dart';

class AuthRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    String errorMessage = '';
    print('email: $email');
    print('first name:$firstName');
    print('last name: $lastName');
    print('password:$password');
    if (email.isEmpty ||
        password.isEmpty ||
        firstName.isEmpty ||
        lastName.isEmpty) {
      errorMessage = 'Please fill the infomrations required.';
      return errorMessage;
    }
    if (password.length < 8 && !password.contains(RegExp(r'[A-Z]'))) {
      errorMessage =
          'Password should contain 8 characters and at least 1 uppercase letter.';
      return errorMessage;
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        UserModel userModel = UserModel(
          email,
          firstName,
          lastName,
          user.uid,
        );
        await _firestore
            .collection('users')
            .doc(user.uid)
            .set(userModel.toJson());
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        print('error: $e');
        if (e.code == 'invalid-email') {
          errorMessage = 'Invalid email format.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Invalid password.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'Email already exits.';
        } else {
          errorMessage = 'Something went wrong.';
        }
      }
    }
    return errorMessage;
  }

  Future<String> logIn({
    required String email,
    required String password,
  }) async {
    String errorMessage = '';
    print('email: $email');
    print('password:$password');
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'invalid-email') {
          errorMessage = 'Invalid email format.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Invalid password.';
        } else {
          if (email.isEmpty) {
            errorMessage = 'Please enter your email.';
          } else if (password.isEmpty) {
            errorMessage = 'Please enter your password.';
          } else {
            errorMessage = 'Email or password may be wrong.';
          }
        }
      }
    }
    return errorMessage;
  }

  void logOut() {
    FirebaseAuth.instance.signOut();
  }
}
