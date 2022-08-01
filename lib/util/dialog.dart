import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Function showLoadingDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => const Center(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    ),
  );
  return () {
    Navigator.pop(context);
  };
}
