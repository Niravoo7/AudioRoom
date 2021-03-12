import 'package:audioroom/custom_widget/search_input_field.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/custom_widget/flexible_widget.dart';
import 'package:audioroom/screen/main_module/search_module/tabs/clubs_screen.dart';
import 'package:audioroom/screen/main_module/search_module/tabs/people_screen.dart';
import 'package:audioroom/screen/main_module/search_module/tabs/top_screen.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:flutter/material.dart';

enum TabItemSearch { top, people, clubs }

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/search';
}

// ignore: must_be_immutable
class SearchScreen extends StatefulWidget {
  Function onConversationsClick;

  SearchScreen(this.onConversationsClick);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TabItemSearch currentTab;

  TextEditingController searchController = new TextEditingController();

  TopScreen topScreen;
  PeopleScreen peopleScreen;
  ClubsScreen clubsScreen;

  Map<TabItemSearch, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItemSearch.top: GlobalKey<NavigatorState>(),
    TabItemSearch.people: GlobalKey<NavigatorState>(),
    TabItemSearch.clubs: GlobalKey<NavigatorState>(),
  };

  @override
  void initState() {
    super.initState();

    topScreen = new TopScreen(widget.onConversationsClick);
    peopleScreen = new PeopleScreen();
    clubsScreen = new ClubsScreen();

    currentTab = TabItemSearch.top;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              SearchInputField(
                  searchInputHintText(currentTab), searchController, true, (text) {}),
              tabBar(context),
              Flexible(
                  child: Stack(children: <Widget>[
                    buildOffstageNavigator(TabItemSearch.top, context),
                    buildOffstageNavigator(TabItemSearch.people, context),
                    buildOffstageNavigator(TabItemSearch.clubs, context),
                  ]),
                  flex: 1),
            ],
          ),
        ),
      ),
    );
  }

  String searchInputHintText(TabItemSearch tabItem) {
    if (tabItem == TabItemSearch.top) {
      return AppConstants.str_search_for_people_and_club;
    } else if (tabItem == TabItemSearch.people) {
      return AppConstants.str_search_for_people;
    } else if (tabItem == TabItemSearch.clubs) {
      return AppConstants.str_search_for_clubs;
    } else {
      return AppConstants.str_search_for_people_and_club;
    }
  }

  // ignore: missing_return
  Map<String, WidgetBuilder> _routeBuilders(
      BuildContext context, TabItemSearch tabItem) {
    if (tabItem == TabItemSearch.top) {
      return {TabNavigatorRoutes.root: (context) => topScreen};
    } else if (tabItem == TabItemSearch.people) {
      return {TabNavigatorRoutes.root: (context) => peopleScreen};
    } else if (tabItem == TabItemSearch.clubs) {
      return {TabNavigatorRoutes.root: (context) => clubsScreen};
    }
  }

  Widget buildOffstageNavigator(TabItemSearch tabItem, BuildContext context) {
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
                  tabWidget(context, TabItemSearch.top, AppConstants.str_top),
              flex: 1),
          Flexible(
              child: tabWidget(
                  context, TabItemSearch.people, AppConstants.str_people),
              flex: 1),
          Flexible(
              child: tabWidget(
                  context, TabItemSearch.clubs, AppConstants.str_clubs),
              flex: 1),
        ],
      ),
    );
  }

  Widget tabWidget(
      BuildContext context, TabItemSearch itenSearch, String tabName) {
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

  onTabClick(TabItemSearch itemSearch) async {
    setState(() {
      currentTab = itemSearch;
    });
  }
}
