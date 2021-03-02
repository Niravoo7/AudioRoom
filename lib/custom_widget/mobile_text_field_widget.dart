import 'package:audioroom/helper/print_log.dart';
import 'package:audioroom/library/country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioroom/helper/constants.dart';

// ignore: non_constant_identifier_names
Widget MobileTextFieldWidget(
    {TextEditingController controller,
    TextInputType keyboardType,
    FormFieldValidator<String> validator,
    ValueChanged<String> onChanged,
    CountryCode countryCode}) {
  return TextFormField(
    minLines: 1,
    maxLines: 1,
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
        hintText: AppConstants.str_mobile_number,
        contentPadding: EdgeInsets.all(0),
        hintStyle: TextStyle(
            color: AppConstants.clrDarkGrey,
            fontWeight: FontWeight.w400,
            fontSize: AppConstants.size_input_text),
        filled: true,
        prefixIcon: Container(
          margin: EdgeInsets.only(right: 10),
          child: CountryCodePicker(
            onChanged: (e) {
              countryCode = e;
              PrintLog.printMessage(
                  e.name + " " + e.code + " " + e.flagUri + " " + e.dialCode);
            },
            initialSelection: 'IN',
            showCountryOnly: true,
            showOnlyCountryWhenClosed: true,
            padding: EdgeInsets.all(0),
            favorite: ['IN'],
          ),
        ),
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
