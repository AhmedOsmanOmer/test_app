import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/controllers/login_controller.dart';
import 'package:test_app/controllers/signUp_controller.dart';
import 'package:test_app/screens/login.dart';
import 'package:test_app/utils/screen_size.dart';
import 'package:test_app/utils/widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final controller = Get.put(SignUpController());
  final login_controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding:
            EdgeInsets.all(ScreenSize(context: context).getHeight() * 0.03),
        child: controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Form(
                key: controller.formKey2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: ScreenSize(context: context).fontSize(50),
                            color: Colors.red),
                      ),
                    ),
                    TextFormField(
                        controller: controller.name,
                        decoration:
                            myDecoration(const Icon(Icons.person), "Username"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Required";
                          }
                          return null;
                        }),

                    //
                    TextFormField(
                        controller: controller.email,
                        decoration: myDecoration(
                            const Icon(Icons.email_outlined), "Email"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Required";
                          } else if (!controller.isValidEmail(value)) {
                            return "Enter a valid email";
                          }
                          return null;
                        }),

                    //
                    TextFormField(
                        controller: controller.password,
                        obscureText: true,
                        decoration: myDecoration(
                            const Icon(Icons.password), "Password"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Required";
                          } else if (value.length < 8) {
                            return "Short Password";
                          }
                          return null;
                        }),
                    //const SizedBox(height: 20),
                    TextFormField(
                        controller: controller.repassword,
                        obscureText: true,
                        decoration: myDecoration(
                            const Icon(Icons.password), "Confirm Password"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Required";
                          } else if (value.length < 8) {
                            return "Short Password";
                          } else if (controller.password.text !=
                              controller.repassword.text) {
                            return "Password doesn't match";
                          }
                          return null;
                        }),
                    //
                    InkWell(
                      onTap: () {
                        controller.signUp(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        height: ScreenSize(context: context).getHeight() * 0.07,
                        width: ScreenSize(context: context).getWidth(),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text("Sign Up"),
                      ),
                    ),
                    //
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("I already have account "),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (builder) => const LoginScreen()));
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.red),
                          ),
                        )
                      ],
                    ),
                    //
                    const Text("Or Continue With"),
                    //
                    GestureDetector(
                      onTap: () {
                        login_controller.signInWithGoogle(context);
                      },
                      child: login_controller.googleLoading
                          ? showLoading()
                          : Container(
                              width:
                                  ScreenSize(context: context).getWidth() * 0.5,
                              height: ScreenSize(context: context).getHeight() *
                                  0.08,
                              padding: const EdgeInsets.all(10),
                              child: Image.asset("assets/google.png"),
                            ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
