import 'package:flutter/material.dart';
import 'package:pairing_app/util/app_constants.dart';
import 'package:pairing_app/util/color_resources.dart';

import '../../util/dimensions.dart';

class CommonTextField extends StatefulWidget {
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? inputType;

  const CommonTextField(
      {this.labelText,
      this.controller,
      this.inputType,
      Key? key})
      : super(key: key);

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool _isHiddenPassword = false;

  @override
  void initState() {
    if(widget.inputType == TextInputType.visiblePassword){
      _isHiddenPassword = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isHiddenPassword ,
      style: const TextStyle(fontFamily: AppConstants.FONT_FAMILY),
      keyboardType: widget.inputType ?? TextInputType.text,
      onSaved: (value) {
        widget.controller!.text = value!;
      },
      autofocus: false,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Please Enter ${widget.labelText}");
        }
        if(widget.labelText == AppConstants.LB_PASSWORD){
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        }
        if(widget.labelText == AppConstants.LB_USERNAME){
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
        }





        return null;

      },
      decoration: InputDecoration(
          focusColor: ColorResources.COLOR_BLACK,
          floatingLabelStyle: const TextStyle(color: ColorResources.COLOR_BLACK),
          focusedBorder:const UnderlineInputBorder(
              borderSide: BorderSide(color: ColorResources.COLOR_BLACK)),
          labelText: widget.labelText ?? "",
          labelStyle: const TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE,
              color: ColorResources.COLOR_GREY,
              fontFamily: AppConstants.FONT_FAMILY),
          suffix: widget.inputType == TextInputType.visiblePassword ? InkWell(
            onTap: _togglePasswordView,  /// This is Magical Function
            child: Icon(
              _isHiddenPassword ?         /// CHeck Show & Hide.
              Icons.visibility :
              Icons.visibility_off,
            ),
          ): SizedBox(),
          contentPadding: const EdgeInsets.all(0)),
      cursorColor: ColorResources.COLOR_BLACK,
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }
}
