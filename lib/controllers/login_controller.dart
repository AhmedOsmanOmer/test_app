// ignore_for_file: use_build_context_synchronously, unused_local_variable, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_app/main.dart';
import 'package:test_app/screens/home.dart';
import 'package:test_app/utils/widgets.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isLoading = false;
    bool googleLoading = false;

  bool isValidEmail(String email) {
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    return emailRegExp.hasMatch(email);
  }

  login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      update();
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: email.text, password: password.text)
            .then((value) {
          isLoading = false;
          update();
          pref.setString('email', email.text);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (builder) => const Home()));
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          isLoading = false;
          update();
          showToast("No user connected with this email", context);
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          isLoading = false;
          update();
          showToast("Wrong Password", context);
          print('Wrong password provided for that user.');
        } else {
          isLoading = false;
          update();
          showToast("Email or Password Incorrect", context);
        }
      }
    }
  }

  ///
  ///
  signInWithGoogle(context) async {
    googleLoading = true;
    update();
    try {
      googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth!.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        pref.setString('email', value.user!.email.toString());
        pref.setString('name', value.user!.displayName.toString());
        pref.setString('image_url', value.user!.photoURL.toString());
        print(
            "================================================================");
        Get.to(() => const Home());
      });
      googleLoading = false;
      update();
    } catch (e) {
      googleLoading = false;
      update();
      print(e.toString());
    }
  }

   

}
