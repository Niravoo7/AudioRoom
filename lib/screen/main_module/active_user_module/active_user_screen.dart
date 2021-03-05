import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/screen/main_module/active_user_module/tabs/all_screen.dart';
import 'package:audioroom/screen/main_module/active_user_module/tabs/people_screen.dart';
import 'package:audioroom/screen/main_module/active_user_module/tabs/clubs_screen.dart';
import 'package:flutter/material.dart';
import 'package:audioroom/custom_widget/search_input_field.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/custom_widget/flexible_widget.dart';

enum TabItemActive { all, people, clubs }

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/active';
}

class ActiveUserScreen extends StatefulWidget {
  @override
  _ActiveUserScreenState createState() => _ActiveUserScreenState();
}

class _ActiveUserScreenState extends State<ActiveUserScreen> {
  TabItemActive currentTab;

  TextEditingController searchController = new TextEditingController();

  AllScreen allScreen;
  PeopleScreen peopleScreen;
  ClubsScreen clubsScreen;

  Map<TabItemActive, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItemActive.all: GlobalKey<NavigatorState>(),
    TabItemActive.people: GlobalKey<NavigatorState>(),
    TabItemActive.clubs: GlobalKey<NavigatorState>(),
  };

  @override
  void initState() {
    super.initState();

    allScreen = new AllScreen();
    peopleScreen = new PeopleScreen();
    clubsScreen = new ClubsScreen();

    currentTab = TabItemActive.all;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              SearchInputField(
                  searchInputHintText(currentTab), searchController, (text) {}),
              tabBar(context),
              Flexible(
                  child: Stack(children: <Widget>[
                    buildOffstageNavigator(TabItemActive.all, context),
                    buildOffstageNavigator(TabItemActive.people, context),
                    buildOffstageNavigator(TabItemActive.clubs, context),
                  ]),
                  flex: 1),
            ],
          ),
        ),
      ),
    );
  }

  String searchInputHintText(TabItemActive tabItem) {
    if (tabItem == TabItemActive.all) {
      return AppConstants.str_search_for_people_and_club;
    } else if (tabItem == TabItemActive.people) {
      return AppConstants.str_search_for_people;
    } else if (tabItem == TabItemActive.clubs) {
      return AppConstants.str_search_for_clubs;
    } else {
      return AppConstants.str_search_for_people_and_club;
    }
  }

  // ignore: missing_return
  Map<String, WidgetBuilder> _routeBuilders(
      BuildContext context, TabItemActive tabItem) {
    if (tabItem == TabItemActive.all) {
      return {TabNavigatorRoutes.root: (context) => allScreen};
    } else if (tabItem == TabItemActive.people) {
      return {TabNavigatorRoutes.root: (context) => peopleScreen};
    } else if (tabItem == TabItemActive.clubs) {
      return {TabNavigatorRoutes.root: (context) => clubsScreen};
    }
  }

  Widget buildOffstageNavigator(TabItemActive tabItem, BuildContext context) {
    var routeBuilders = _routeBuilders(context, tabItem);
    return Offstage(
      offstage: currentTab != tabItem,
      child: Navigator(
          key: navigatorKeys[tabItem],
          initialRoute: TabNavigatorRoutes.root,
          onGenerateRoute: (routeSettings) {
            return MaterialPageRoute(
                builder: (context) =>
                    routeBuilders[routeSettings.name](context));
          }),
    );
  }

  Widget tabBar(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(color: AppConstants.clrWhite),
      child: Row(
        children: <Widget>[
          Flexible(
              child:
                  tabWidget(context, TabItemActive.all, AppConstants.str_all),
              flex: 1),
          Flexible(
              child: tabWidget(
                  context, TabItemActive.people, AppConstants.str_people),
              flex: 1),
          Flexible(
              child: tabWidget(
                  context, TabItemActive.clubs, AppConstants.str_clubs),
              flex: 1),
        ],
      ),
    );
  }

  Widget tabWidget(
      BuildContext context, TabItemActive itenSearch, String tabName) {
    return GestureDetector(
      onTap: () {
        onTabClick(itenSearch);
      },
      child: GestureDetector(
        child: Container(
          height: 40,
          color: AppConstants.clrWhite,
          alignment: Alignment.center,
          child: Column(
            children: [
              FlexibleWidget(1),
              TextWidget(tabName,
                  color: (itenSearch == currentTab)
                      ? AppConstants.clrBlack
                      : AppConstants.clrSearchIconColor,
                  fontSize: AppConstants.size_medium,
                  fontWeight: FontWeight.bold),
              FlexibleWidget(1),
              DividerWidget(
                  height: 2,
                  color: (itenSearch == currentTab)
                      ? AppConstants.clrBlack
                      : AppConstants.clrTransparent),
              DividerWidget(height: 1, color: AppConstants.clrSearchBG)
            ],
          ),
        ),
        onTap: () {
          onTabClick(itenSearch);
        },
      ),
    );
  }

  onTabClick(TabItemActive itemSearch) async {
    setState(() {
      currentTab = itemSearch;
    });
  }
}
