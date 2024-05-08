import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

InputDecoration myDecoration(icon, label) {
  return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 15),
      prefixIcon: icon,
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ));
  /*  border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(color: Colors.white), // White border color
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(color: Colors.red), // White border color
      )); */
}

Widget internetError() {
  return Container(
    height: 200,
    alignment: Alignment.center,
    child: Column(
      children: [
        Icon(Icons.network_wifi_1_bar_outlined,
            color: Colors.red[900], size: 50),
        const SizedBox(height: 10),
        const Text("No Internet")
      ],
    ),
  );
}

showToast(String msg, context) {
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    alignment: Alignment.center,
    content: Text(
      msg,
      style: const TextStyle(color: Colors.red),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

GoogleSignInAccount? googleUser;
 Widget showLoading() {
    return const Center(child: CircularProgressIndicator(
      color: Colors.red,
    ));
  }