import 'package:audioroom/custom_widget/button_widget.dart';
import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/custom_widget/text_field_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewEventScreen extends StatefulWidget {
  @override
  _NewEventScreenState createState() => _NewEventScreenState();
}

class _NewEventScreenState extends State<NewEventScreen> {
  TextEditingController eventNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //eventNameController.text = "test";
    //dateController.text = "test";
    //timeController.text = "test";
    //descriptionController.text = "about info";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
            appBar: CommonAppBar(context, "New Event", true, false, null),
            body: SafeArea(
                child: Container(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(child: inputFields(), flex: 1),
                          ButtonWidget(context, AppConstants.str_publish, () {
                            Navigator.pop(context);
                          })
                        ])))));
  }

  Widget inputFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextWidget(AppConstants.str_event_name,
            color: AppConstants.clrBlack,
            fontSize: AppConstants.size_medium_large,
            fontWeight: FontWeight.bold),
        SizedBox(height: 8),
        TextFieldWidget(
            controller: eventNameController,
            keyboardType: TextInputType.text,
            hintText: AppConstants.str_write_a_title_for_the_event),
        SizedBox(height: 16),
        TextWidget(AppConstants.str_with,
            color: AppConstants.clrBlack,
            fontSize: AppConstants.size_medium_large,
            fontWeight: FontWeight.bold),
        SizedBox(height: 8),
        Row(
          children: [
            Container(
                height: 22,
                width: 22,
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                    color: AppConstants.clrGreen,
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: NetworkImage(AppConstants.str_image_url)))),
            TextWidget(AppConstants.str_melinda_livsey,
                color: AppConstants.clrBlack,
                fontSize: AppConstants.size_medium_large,
                fontWeight: FontWeight.w400),
          ],
        ),
        Container(
          height: 50,
          margin: EdgeInsets.only(top: 8),
          padding: EdgeInsets.only(left: 8, right: 8),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border.all(color: AppConstants.clrGrey),
              borderRadius: BorderRadius.circular(5)),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Flexible(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextWidget(AppConstants.str_add_a_co_host_or_guest,
                      color: AppConstants.clrBlack,
                      fontSize: AppConstants.size_medium_large,
                      fontWeight: FontWeight.w400),
                ),
                flex: 1,
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
        SizedBox(height: 16),
        TextWidget(AppConstants.str_date,
            color: AppConstants.clrBlack,
            fontSize: AppConstants.size_medium_large,
            fontWeight: FontWeight.bold),
        SizedBox(height: 8),
        TextFieldWidget(
            controller: dateController, keyboardType: TextInputType.text),
        SizedBox(height: 16),
        TextWidget(AppConstants.str_time,
            color: AppConstants.clrBlack,
            fontSize: AppConstants.size_medium_large,
            fontWeight: FontWeight.bold),
        SizedBox(height: 8),
        TextFieldWidget(
            controller: timeController, keyboardType: TextInputType.text),
        SizedBox(height: 16),
        TextWidget(AppConstants.str_description,
            color: AppConstants.clrBlack,
            fontSize: AppConstants.size_medium_large,
            fontWeight: FontWeight.bold),
        SizedBox(height: 8),
        TextFieldWidget(
            controller: descriptionController,
            hintText: AppConstants.str_write_the_event_details,
            keyboardType: TextInputType.text,
            lines: 4),
      ],
    );
  }
}
