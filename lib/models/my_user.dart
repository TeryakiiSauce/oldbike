import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyUser {
  final _auth = FirebaseAuth.instance;

  String? firstName, lastName, email, gender, bloodGroup, password;
  DateTime? dob;
  double? weight, height;

  MyUser({
    required this.email,
    required this.password,
    this.firstName,
    this.lastName,
    this.gender,
    this.bloodGroup,
    this.dob,
    this.height,
    this.weight,
  });

  User? getUserInfo() {
    return _auth.currentUser;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String> createUser() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      return '';
    } catch (e) {
      debugPrint('Error occurred: $e');
      return 'Error occurred: $e';
    }
  }

  Future<bool> signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      return true;
    } catch (e) {
      debugPrint('Error occurred: $e');
      return false;
    }
  }

  Map<String, dynamic> toJSON() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'bloodGroup': bloodGroup,
      'dob': dob,
      'height': height,
      'weight': weight,
    };
  }

  static MyUser createObject(QueryDocumentSnapshot<Object?>? userDataDoc) =>
      MyUser(
        email: '',
        password: '',
        firstName: userDataDoc?.get('firstName'),
        lastName: userDataDoc?.get('lastName'),
        gender: userDataDoc?.get('gender'),
        bloodGroup: userDataDoc?.get('bloodGroup'),
        dob: userDataDoc?.get('dob'),
        height: userDataDoc?.get('height'),
        weight: userDataDoc?.get('weight'),
      );

  Future<void> uploadUserInfo() async {
    debugPrint(
      'Email: $email\ndata to be uploaded: ${toJSON()}',
    );

    // Reference: https://stackoverflow.com/a/55328839
    final CollectionReference userInfoReference =
        FirebaseFirestore.instance.collection('/users-info');

    await userInfoReference.doc(email).set(toJSON());

    debugPrint('uploaded user info to database');
  }

  /// [Deprecated]
  @Deprecated('No need to use this method, it\'s unnecessary.')
  void signInAnon() async {
    try {
      await _auth.signInAnonymously();
    } catch (e) {
      debugPrint('Error occurred: $e');
    }
  }
}
