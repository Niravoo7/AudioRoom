import 'package:audioroom/custom_widget/invite_people_widget.dart';
import 'package:flutter/material.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/screen/main_module/invite_module/pending_invite_screen.dart';
import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/custom_widget/search_input_field.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/helper/navigate_effect.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class InviteScreen extends StatefulWidget {
  @override
  _InviteScreenState createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
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
      appBar: CommonAppBar(context, "Invites", true, false, null),
      body: SafeArea(
          child: Container(
              child:
                  inviteListWidget() /*(followPeopleModels.length != 0)
                  ? inviteListWidget()
                  : emptyListWidget()*/
              )),
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
                    textAlign: TextAlign.center),
              )
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
      )
    ]);
  }

  Widget emptyListWidget() {
    return Container(
        margin: EdgeInsets.all(16),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextWidget(AppConstants.str_empty_invites_list,
              color: AppConstants.clrBlack,
              fontSize: AppConstants.size_medium_large,
              fontWeight: FontWeight.bold,
              maxLines: 10,
              textAlign: TextAlign.center),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context, NavigatePageRoute(context, PendingInviteScreen()));
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    alignment: Alignment.center,
                    height: 36,
                    margin: EdgeInsets.only(right: 16, top: 16),
                    padding: EdgeInsets.only(left: 24, right: 24),
                    decoration: BoxDecoration(
                      color: AppConstants.clrPrimary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextWidget(AppConstants.str_pending_invites,
                        color: AppConstants.clrWhite,
                        fontSize: AppConstants.size_medium,
                        fontWeight: FontWeight.bold,
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis)),
              ]))
        ]));
  }
}
