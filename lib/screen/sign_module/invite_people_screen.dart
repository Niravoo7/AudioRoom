import 'package:audioroom/custom_widget/button_widget.dart';
import 'package:audioroom/screen/sign_module/account_created_screen.dart';
import 'package:flutter/material.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/custom_widget/invite_people_widget.dart';
import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/custom_widget/search_input_field.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/helper/navigate_effect.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class InvitePeopleScreen extends StatefulWidget {
  @override
  _InvitePeopleScreenState createState() => _InvitePeopleScreenState();
}

class _InvitePeopleScreenState extends State<InvitePeopleScreen> {
  TextEditingController searchController = new TextEditingController();
  List<String> strInvited = [];

  List<Contact> contacts;
  bool permissionDenied = false;

  @override
  void initState() {
    super.initState();
    fetchContacts();
  }

  Future fetchContacts() async {
    if (!await FlutterContacts.requestPermission()) {
      setState(() => permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts();
      setState(() => this.contacts = contacts);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(context, "Invite people", true, true, () {
        Navigator.push(
            context, NavigatePageRoute(context, AccountCreatedScreen()));
      }),
      body: SafeArea(child: Container(child: inviteListWidget())),
    );
  }

  Widget inviteListWidget() {
    return Column(children: [
      SearchInputField(
          AppConstants.str_search_for_people, searchController, true, (text) {
        setState(() {});
      }),
      DividerWidget(height: 1),
      Flexible(
        child: (permissionDenied)
            ? Center(
                child: TextWidget("Permission denied",
                    color: AppConstants.clrBlack,
                    fontSize: AppConstants.size_medium_large,
                    textAlign: TextAlign.center))
            : (contacts != null && contacts.length > 0)
                ? ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, i) {
                      return InvitePeopleWidget(
                          context,
                          contacts[i].displayName,
                          (contacts[i].phones.length > 0)
                              ? contacts[i].phones[0].number
                              : null,
                          strInvited.contains(contacts[i].displayName),
                          onInviteClick: () {
                        if (strInvited.contains(contacts[i].displayName)) {
                          strInvited.remove(contacts[i].displayName);
                        } else {
                          strInvited.add(contacts[i].displayName);
                        }
                        setState(() {});
                      });
                    })
                : Container(),
        flex: 1,
      ),
      Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: ButtonWidget(context, AppConstants.str_create_account, () {
            submitEvent();
          }))
    ]);
  }

  void submitEvent() {
    Navigator.push(context, NavigatePageRoute(context, AccountCreatedScreen()));
  }
}
