// ignore_for_file: use_build_context_synchronously, avoid_print, invalid_return_type_for_catch_error, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/screens/home.dart';
import 'package:test_app/utils/widgets.dart';

class SignUpController extends GetxController {
  bool isLoading = false;
  var formKey2 = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repassword = TextEditingController();
//////
  ///

  bool isValidEmail(String email) {
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    return emailRegExp.hasMatch(email);
  }

  storeUserData(BuildContext context, String id) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.add({
      'name': name.text,
      'email': email.text,
    }).then((value) async {
      print("User Added");
    }).catchError((error) => print("Failed to add user: $error"));
  }

  signUp(BuildContext context) async {
    var auth = FirebaseAuth.instance;
    if (formKey2.currentState!.validate()) {
      isLoading = true;
      update();
      try {
        final credential = await auth.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        storeUserData(context, auth.currentUser!.uid);

        isLoading = false;
        update();
        Get.to(() => const Home());
      
        showToast("SignUp Success Login Now", context);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          isLoading = false;
          update();
          showToast("Weak Password", context);
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          isLoading = false;
          update();
          showToast("Email Already Exist", context);
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
