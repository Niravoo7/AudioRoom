import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioroom/helper/constants.dart';

// ignore: non_constant_identifier_names
Widget TextFieldWidget(
    {TextEditingController controller,
    String hintText,
    TextInputType keyboardType,
    FormFieldValidator<String> validator,
    ValueChanged<String> onChanged,
    int lines}) {
  return TextFormField(
    minLines: (lines != null) ? lines : 1,
    maxLines: (lines != null) ? lines : 1,
    keyboardType: keyboardType,
    controller: controller,
    autocorrect: true,
    scrollPadding: EdgeInsets.all(0),
    textAlign: TextAlign.start,
    textAlignVertical: TextAlignVertical.center,
    style: TextStyle(
        color: AppConstants.clrBlack,
        fontSize: AppConstants.size_medium_large,
        fontWeight: FontWeight.w400),
    decoration: InputDecoration(
        contentPadding:
            EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        hintText: hintText,
        hintStyle: TextStyle(
            color: AppConstants.clrDarkGrey,
            fontWeight: FontWeight.w400,
            fontSize: AppConstants.size_input_text),
        filled: true,
        fillColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            gapPadding: 0,
            borderSide: BorderSide(color: AppConstants.clrDivider, width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            gapPadding: 0,
            borderSide: BorderSide(color: AppConstants.clrPrimary, width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            gapPadding: 0,
            borderSide: BorderSide(color: AppConstants.clrDivider, width: 1)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            gapPadding: 0,
            borderSide: BorderSide(color: AppConstants.clrDivider, width: 1)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            gapPadding: 0,
            borderSide: BorderSide(color: AppConstants.clrDivider, width: 1))),
    validator: validator,
    onChanged: onChanged,
  );
}
