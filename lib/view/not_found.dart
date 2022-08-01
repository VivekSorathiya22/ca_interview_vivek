import 'package:flutter/material.dart';

import '../util/app_constants.dart';

class NotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder(
          curve: Curves.bounceOut,
          duration: const Duration(seconds: 2),
          tween: Tween<double>(begin: 12.0, end: 30.0),
          builder: (BuildContext? context, dynamic value, Widget? child) {
            return Text(AppConstants.PAGE_NOT_FOUND,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: value));
          },
        ),
      ),
    );
  }
}
