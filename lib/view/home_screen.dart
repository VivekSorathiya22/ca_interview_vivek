import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:location/location.dart';
import 'package:pairing_app/util/app_constants.dart';
import 'package:pairing_app/util/color_resources.dart';
import 'package:pairing_app/util/dimensions.dart';

import '../util/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Location location = new Location();
  PermissionStatus? _permissionGranted;
  CircleColorPickerController? controller =
      CircleColorPickerController(initialColor: ColorResources.COLOR_SKY);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.logout),
                    color: ColorResources.COLOR_BLACK,
                    onPressed: () async {
                      await logout(context);
                    },
                  ),
                  const Text(
                    AppConstants.LB_HOME,
                    style: TextStyle(
                        color: ColorResources.COLOR_BLACK,
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                        fontFamily: AppConstants.FONT_FAMILY,
                        fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    onTap: () async {
                      _permissionGranted = await location.hasPermission();
                      if (_permissionGranted == PermissionStatus.denied) {
                        _permissionGranted = await location.requestPermission();
                        if (_permissionGranted != PermissionStatus.granted) {
                          Navigator.pushNamed(context, Routes.getSuccessRoute());
                        }
                        else{
                          Navigator.pushNamed(context, Routes.getDeniedRoute());
                        }
                      }
                      else{
                        Navigator.pushNamed(context, Routes.getSuccessRoute());
                      }
                    },
                    child: const Text(
                      AppConstants.LB_PAIR,
                      style: TextStyle(
                          color: ColorResources.COLOR_BLACK,
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          fontFamily: AppConstants.FONT_FAMILY,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 70),
            CircleColorPicker(
              controller: controller,
              onChanged: (Color color) {
                setState(() {});
              },
              strokeWidth: 15.0,
              colorCodeBuilder: (context, color) {
                return const SizedBox();
              },
            ),
          ], // Navigator.pushNamed(context, Routes.getSuccessRoute());
        ),
      ),
    );
  }


  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.getLoginRoute(), (route) => false);
  }
}
