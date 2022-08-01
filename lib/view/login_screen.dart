import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pairing_app/util/app_constants.dart';
import 'package:pairing_app/util/color_resources.dart';
import 'package:pairing_app/util/dimensions.dart';
import 'package:pairing_app/view/base/common_textfield.dart';

import '../util/dialog.dart';
import '../util/images.dart';
import '../util/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController ctrUserName = TextEditingController();
  TextEditingController ctrPassword = TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Images.bg_primary), fit: BoxFit.cover)),
      child: Stack(
        children: [
          Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                const Center(
                  child: Text(
                    AppConstants.LB_SIGN_IN_TO_ACCOUNT,
                    style: TextStyle(
                        color: ColorResources.COLOR_BLACK,
                        fontFamily: AppConstants.FONT_FAMILY,
                        fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding:
                          const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 12),
                            CommonTextField(
                              controller: ctrUserName,
                              labelText: AppConstants.LB_USERNAME,
                            ),
                            const SizedBox(height: 12),
                            CommonTextField(
                              controller: ctrPassword,
                              labelText: AppConstants.LB_PASSWORD,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: const [
                                Spacer(),
                                Text(
                                  AppConstants.LB_FORGOTE_PASSWORD,
                                  style: TextStyle(
                                      color: ColorResources.COLOR_SKY,
                                      fontFamily: AppConstants.FONT_FAMILY,
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                  child: InkWell(
                    onTap: () {
                      signIn(ctrUserName.text, ctrPassword.text);
                    },
                    child: Container(
                      color: ColorResources.COLOR_SKY,
                      child: const Padding(
                        padding:
                            EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                        child: Center(
                          child: Text(
                            AppConstants.LB_SIGN_IN,
                            style: TextStyle(
                                color: ColorResources.COLOR_WHITE,
                                fontWeight: FontWeight.w700,
                                fontSize: Dimensions.PADDING_SIZE_DEFAULT),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    Dimensions.PADDING_SIZE_EXTRA_LARGE,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Spacer(),
                      Row(
                        children: [
                          const Text(
                            AppConstants.LB_DONT_HAVE_ACCOUNT,
                            style: TextStyle(
                                color: ColorResources.COLOR_GREY,
                                fontSize: Dimensions.FONT_SIZE_LARGE,
                                fontFamily: AppConstants.FONT_FAMILY,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(width: 4),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.getSignUpRoute());
                            },
                            child: const Text(
                              AppConstants.LB_SIGN_UP,
                              style: TextStyle(
                                  color: ColorResources.COLOR_SKY,
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                  fontFamily: AppConstants.FONT_FAMILY,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }

  //login function
  void signIn(String email, String password) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final pop = showLoadingDialog(context);
    if (_formKey.currentState!.validate()) {
      try {
        pop();
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.pushNamedAndRemoveUntil(
                      context, Routes.getHomeRoute(), (route) => false)
                });
      } on FirebaseAuthException catch (error) {
        pop();
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}
