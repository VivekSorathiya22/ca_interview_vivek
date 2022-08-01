import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pairing_app/util/app_constants.dart';
import 'package:pairing_app/util/color_resources.dart';
import 'package:pairing_app/util/dimensions.dart';
import 'package:pairing_app/util/images.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          AppConstants.LB_PARING_DONE,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: ColorResources.COLOR_GREY,
            fontSize: Dimensions.FONT_SIZE_LARGE,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorResources.COLOR_GREY,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Image.asset(Images.bg_success, fit: BoxFit.fill),
              const Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: Text(
                  AppConstants.LB_YOU_ARE_ALL_SET,
                  style: TextStyle(
                      color: ColorResources.COLOR_GREY,
                      fontFamily: AppConstants.FONT_FAMILY,
                      fontSize: Dimensions.FONT_SIZE_OVER_LARGE),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
