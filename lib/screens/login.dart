import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/controllers/login_controller.dart';
import 'package:test_app/utils/screen_size.dart';
import 'package:test_app/screens/signup.dart';
import 'package:test_app/utils/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

      final controller = Get.put(LoginController());

   @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenSize(context: context).getHeight() * 0.04,
            vertical: ScreenSize(context: context).getHeight() * 0.07),
        child:controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.red),
              )
            : Form(
                key: controller.formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: ScreenSize(context: context).getWidth() * 0.2,
                        backgroundImage: const AssetImage("assets/logo.png"),
                      ),
                      SizedBox(
                          height:
                              ScreenSize(context: context).getHeight() * 0.05),
                      TextFormField(
                        controller: controller.email,
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Required";
                          }
                          if (!controller.isValidEmail(val)) {
                            return "Enter a valid Email";
                          }
                          return null;
                        },
                        decoration: myDecoration(
                            const Icon(Icons.email_outlined), "Email"),
                      ),
                      SizedBox(
                          height:
                              ScreenSize(context: context).getHeight() * 0.03),
                      TextFormField(
                          controller: controller.password,
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus!.unfocus();
                          },
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            }
                            if (value.length < 8) {
                              return "Short Password";
                            }

                            return null;
                          },
                          decoration: myDecoration(
                              const Icon(Icons.password), "Password")),
                      SizedBox(
                          height:
                              ScreenSize(context: context).getHeight() * 0.03),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forget My Password",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.red),
                        ),
                      ),
                      SizedBox(
                          height:
                              ScreenSize(context: context).getHeight() * 0.03),
                      InkWell(
                        onTap: () {
                          controller.login(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.center,
                          height:
                              ScreenSize(context: context).getHeight() * 0.06,
                          width: ScreenSize(context: context).getWidth(),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text("Login",
                              style: TextStyle(
                                  fontSize: ScreenSize(context: context)
                                      .fontSize(25))),
                        ),
                      ),
                      SizedBox(
                          height:
                              ScreenSize(context: context).getHeight() * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Dont have account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (builder) => const SignUpScreen()));
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.red,
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                          height:
                              ScreenSize(context: context).getHeight() * 0.07),
                      const Text("Or Continue With"),
                      const SizedBox(height: 50),
                      controller.googleLoading
                          ? showLoading()
                          : InkWell(
                              onTap: () {
                                controller.signInWithGoogle(context);
                              },
                              child: Container(
                                width: ScreenSize(context: context).getWidth() *
                                    0.5,
                                height:
                                    ScreenSize(context: context).getHeight() *
                                        0.08,
                                padding: const EdgeInsets.all(10),
                                child: Image.asset("assets/google.png"),
                              ),
                            )
                    ]),
              ),
      ),
    ));
  }

  ////
  ///
  ///
  }
