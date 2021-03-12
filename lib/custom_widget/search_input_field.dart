import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioroom/helper/constants.dart';

// ignore: must_be_immutable
class SearchInputField extends StatelessWidget {
  String hintText;
  TextEditingController controller;
  bool isSearchIconVisible;
  void Function(String) callback;

  SearchInputField(
      this.hintText, this.controller, this.isSearchIconVisible, this.callback);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppConstants.clrSearchBG,
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            hintText: hintText,
            focusColor: AppConstants.clrBlack,
            filled: true,
            fillColor: AppConstants.clrSearchBG,
            contentPadding: (isSearchIconVisible)
                ? EdgeInsets.all(0)
                : EdgeInsets.only(left: 15),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gapPadding: 0,
                borderSide:
                    BorderSide(color: AppConstants.clrTransparent, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gapPadding: 0,
                borderSide:
                    BorderSide(color: AppConstants.clrTransparent, width: 1)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gapPadding: 0,
                borderSide:
                    BorderSide(color: AppConstants.clrTransparent, width: 1)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gapPadding: 0,
                borderSide:
                    BorderSide(color: AppConstants.clrTransparent, width: 1)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gapPadding: 0,
                borderSide:
                    BorderSide(color: AppConstants.clrTransparent, width: 1)),
            prefixIcon: (isSearchIconVisible)
                ? Container(
                    width: 40,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Image.asset(
                            AppConstants.img_search,
                            height: 18,
                            color: AppConstants.clrSearchIconColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : null),
        style: TextStyle(
            fontFamily: AppConstants.fontGothic,
            fontSize: AppConstants.size_medium_large,
            color: AppConstants.clrBlack,
            fontWeight: FontWeight.w400),
        onChanged: (text) {
          callback(text);
        },
      ),
    );
  }
}
