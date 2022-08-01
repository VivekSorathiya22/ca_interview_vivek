import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../util/app_constants.dart';
import '../util/color_resources.dart';
import '../util/dimensions.dart';
import '../util/images.dart';
import '../util/routes.dart';

class LocationDeniedScreen extends StatelessWidget {
  const LocationDeniedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Location location = new Location();
    PermissionStatus? _permissionGranted;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: null,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorResources.COLOR_BLACK,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Center(
                        child:
                            Image.asset(Images.ic_location, fit: BoxFit.fill)),
                  ),
                  const Text(
                    AppConstants.LB_LOCATION_PERMISSION,
                    style: TextStyle(
                        color: ColorResources.COLOR_BLACK,
                        fontWeight: FontWeight.w700,
                        fontFamily: AppConstants.FONT_FAMILY,
                        fontSize: Dimensions.FONT_SIZE_OVER_LARGE),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    AppConstants.LB_LOCATION_PERMISSION_LINE_1,
                    style: TextStyle(
                        color: ColorResources.COLOR_BLACK,
                        fontFamily: AppConstants.FONT_FAMILY,
                        fontSize: Dimensions.FONT_SIZE_DEFAULT),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    AppConstants.LB_LOCATION_PERMISSION_LINE_3,
                    style: TextStyle(
                        color: ColorResources.COLOR_BLACK,
                        fontFamily: AppConstants.FONT_FAMILY,
                        fontSize: Dimensions.FONT_SIZE_DEFAULT),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    AppConstants.LB_LOCATION_PERMISSION_LINE_3,
                    style: TextStyle(
                        color: ColorResources.COLOR_BLACK,
                        fontFamily: AppConstants.FONT_FAMILY,
                        fontSize: Dimensions.FONT_SIZE_DEFAULT),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                child: InkWell(
                  onTap: () async {
                    _permissionGranted = await location.hasPermission();
                    if (_permissionGranted == PermissionStatus.denied) {
                      _permissionGranted = await location.requestPermission();
                      if (_permissionGranted != PermissionStatus.granted) {
                        _permissionGranted = await location.requestPermission();
                      }
                    } else{
                      Navigator.pushNamed(context, Routes.getSuccessRoute());
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorResources.COLOR_GREEN,
                        borderRadius: BorderRadius.circular(30)),
                    child: const Padding(
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                      child: Center(
                        child: Text(
                          AppConstants.LB_CHANGES,
                          style: TextStyle(
                              color: ColorResources.COLOR_WHITE,
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                              fontWeight: FontWeight.w700,
                              fontFamily: AppConstants.FONT_FAMILY),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
