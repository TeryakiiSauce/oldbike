import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oldbike/models/ride_stats.dart';

class MyUser {
  final _auth = FirebaseAuth.instance;

  String? firstName,
      lastName,
      email,
      gender,
      bloodGroup,
      // username,
      password;
  DateTime? dob;
  double? weight, height;
  List<RideStatistics>? rides;
  // final DateTime dateCreated, loginDate;

  MyUser({
    // required this.username,
    required this.email,
    required this.password,
    this.firstName,
    this.lastName,
    this.gender,
    this.bloodGroup,
    this.dob,
    this.height,
    this.weight,
    this.rides,
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

  // [Deprecated] Not used
  void signInAnon() async {
    try {
      await _auth.signInAnonymously();
    } catch (e) {
      debugPrint('Error occurred: $e');
    }
  }
}
