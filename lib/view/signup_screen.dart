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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  final _formKey = GlobalKey<FormState>();
  TextEditingController ctrUserName = TextEditingController();
  TextEditingController ctrRestaurantName = TextEditingController();
  TextEditingController ctrRestaurantUserName = TextEditingController();
  TextEditingController ctrPassword = TextEditingController();
  TextEditingController ctrConfirmPassword = TextEditingController();

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
                      AppConstants.LB_CREATE_NEW_ACCOUNT,
                      style: TextStyle(
                          color: ColorResources.COLOR_BLACK,
                          fontFamily: AppConstants.FONT_FAMILY,
                          fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
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
                                controller: ctrRestaurantName,
                                labelText: AppConstants.LB_RESTAURANT_NAME,
                              ),
                              const SizedBox(height: 12),
                              CommonTextField(
                                controller: ctrRestaurantUserName,
                                labelText: AppConstants.LB_RESTAURANT_USER_NAME,
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                AppConstants.LB_USER_NAME_SHOULD_BE_UNIQUE,
                                style: TextStyle(
                                    color: ColorResources.COLOR_GREY,
                                    fontFamily: AppConstants.FONT_FAMILY,
                                    fontSize: Dimensions.FONT_SIZE_SMALL),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              CommonTextField(
                                controller: ctrPassword,
                                inputType: TextInputType.visiblePassword,
                                labelText: AppConstants.LB_PASSWORD,
                              ),
                              const SizedBox(height: 12),
                              CommonTextField(
                                controller: ctrConfirmPassword,
                                inputType: TextInputType.visiblePassword,
                                labelText: AppConstants.LB_CONFIRM_PASSWORD,
                              ),
                              const SizedBox(height: 15),
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
                      onTap: () async {
                        if (ctrPassword.text != ctrConfirmPassword.text) {
                          Fluttertoast.showToast(msg: "Password don't match ");
                        } else {
                          signUp(ctrUserName.text, ctrPassword.text);
                        }
                      },
                      child: Container(
                        color: ColorResources.COLOR_SKY,
                        child: const Padding(
                          padding:
                              EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                          child: Center(
                            child: Text(
                              AppConstants.LB_SIGN_UP,
                              style: TextStyle(
                                  color: ColorResources.COLOR_WHITE,
                                  fontWeight: FontWeight.w700,
                                  fontSize: Dimensions.FONT_SIZE_LARGE),
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
                              AppConstants.LB_ALREADY_HAVE_AN_ACCOUNT,
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
                                    context, Routes.getLoginRoute());
                              },
                              child: const Text(
                                AppConstants.LB_SIGN_IN,
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
      ),
    );
  }

  void signUp(String email, String password) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final pop = showLoadingDialog(context);
    if (_formKey.currentState!.validate()) {
      try {
        pop();
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
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

  postDetailsToFirestore() async {
    // FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    // User? user = _auth.currentUser;
    // UserModel userModel = UserModel();
    // userModel.email = user!.email;
    // userModel.uid = user.uid;
    // userModel.restaurantName = ctrRestaurantName.text;
    // userModel.restaurantUserName = ctrRestaurantUserName.text;
    // await firebaseFirestore
    //     .collection("users")
    //     .doc(user.uid)
    //     .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.getHomeRoute(), (route) => false);
  }
}
