import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/helper/navigate_effect.dart';
import 'package:audioroom/helper/validate.dart';
import 'package:audioroom/screen/main_module/active_user_module/active_user_screen.dart';
import 'package:audioroom/screen/main_module/home_module/home_screen.dart';
import 'package:audioroom/screen/main_module/room_module/start_room_screen.dart';
import 'package:audioroom/screen/main_module/search_module/search_screen.dart';
import 'package:audioroom/screen/main_module/upcoming_module/upcoming_screen.dart';
import 'package:audioroom/screen/main_module/profile_module/profile_screen.dart';
import 'package:audioroom/screen/main_module/notification_module/notification_screen.dart';
import 'package:audioroom/screen/main_module/invite_module/invite_screen.dart';
import 'package:audioroom/custom_widget/flexible_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:flutter/material.dart';

enum TabItemMain { home, search, room, upcoming, active }

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/main';
}

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  TabItemMain currentTab;

  HomeScreen homeScreen;
  SearchScreen searchScreen;
  StartRoomScreen startRoomScreen;
  UpcomingScreen upcomingScreen;
  ActiveUserScreen activeUserScreen;

  DateTime currentBackPressTime;

  String appbarName = AppConstants.str_tab_room;

  Map<TabItemMain, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItemMain.home: GlobalKey<NavigatorState>(),
    TabItemMain.search: GlobalKey<NavigatorState>(),
    TabItemMain.room: GlobalKey<NavigatorState>(),
    TabItemMain.upcoming: GlobalKey<NavigatorState>(),
    TabItemMain.active: GlobalKey<NavigatorState>(),
  };

  @override
  void initState() {
    super.initState();

    homeScreen = new HomeScreen();
    searchScreen = new SearchScreen();
    startRoomScreen = new StartRoomScreen();
    upcomingScreen = new UpcomingScreen();
    activeUserScreen = new ActiveUserScreen();

    currentTab = TabItemMain.room;
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      showToast("Press again to exit!");
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!navigatorKeys[currentTab].currentState.canPop()) {
          onWillPop();
        } else {
          !await navigatorKeys[currentTab].currentState.maybePop();
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          backgroundColor: AppConstants.clrWhite,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                alignment: Alignment.center,
                child: TextWidget(appbarName,
                    color: AppConstants.clrBlack,
                    fontSize: AppConstants.size_medium_large,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                child: Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        height: 50,
                        width: 50,
                        color: AppConstants.clrTransparent,
                        padding: EdgeInsets.all(16),
                        child: Image.asset(
                          AppConstants.ic_add_mail,
                          height: 18,
                          width: 18,
                          color: AppConstants.clrBlack,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            NavigatePageRoute(context, InviteScreen()));
                      },
                    ),
                    FlexibleWidget(1),
                    GestureDetector(
                      child: Container(
                        height: 50,
                        width: 50,
                        color: AppConstants.clrTransparent,
                        padding: EdgeInsets.all(16),
                        child: Image.asset(
                          AppConstants.ic_notification,
                          height: 18,
                          width: 18,
                          color: AppConstants.clrBlack,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            NavigatePageRoute(context, NotificationScreen()));
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        width: 50,
                        height: 50,
                        child: Container(
                            height: 40,
                            width: 40,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: AppConstants.clrProfileBG,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        AppConstants.str_image_url),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            NavigatePageRoute(context, ProfileScreen(false)));
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                Flexible(
                    child: Stack(children: <Widget>[
                      buildOffstageNavigator(TabItemMain.home, context),
                      buildOffstageNavigator(TabItemMain.search, context),
                      buildOffstageNavigator(TabItemMain.room, context),
                      buildOffstageNavigator(TabItemMain.upcoming, context),
                      buildOffstageNavigator(TabItemMain.active, context),
                    ]),
                    flex: 1),
                DividerWidget(
                    height: 2, width: MediaQuery.of(context).size.width),
                bottomBar(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: missing_return
  Map<String, WidgetBuilder> _routeBuilders(
      BuildContext context, TabItemMain tabItem) {
    if (tabItem == TabItemMain.home) {
      return {TabNavigatorRoutes.root: (context) => homeScreen};
    } else if (tabItem == TabItemMain.search) {
      return {TabNavigatorRoutes.root: (context) => searchScreen};
    } else if (tabItem == TabItemMain.room) {
      return {TabNavigatorRoutes.root: (context) => startRoomScreen};
    } else if (tabItem == TabItemMain.upcoming) {
      return {TabNavigatorRoutes.root: (context) => upcomingScreen};
    } else if (tabItem == TabItemMain.active) {
      return {TabNavigatorRoutes.root: (context) => activeUserScreen};
    }
  }

  Widget buildOffstageNavigator(TabItemMain tabItem, BuildContext context) {
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

  Widget bottomBar(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(color: AppConstants.clrWhite),
      child: Row(
        children: <Widget>[
          Flexible(
              child: tabWidget(context, TabItemMain.home, AppConstants.ic_home,
                  AppConstants.str_tab_home),
              flex: 1),
          Flexible(
              child: tabWidget(context, TabItemMain.search,
                  AppConstants.ic_search, AppConstants.str_tab_search),
              flex: 1),
          Flexible(
              child: GestureDetector(
                onTap: () {
                  appbarName = AppConstants.str_tab_room;
                  onTabClick(TabItemMain.room);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppConstants.clrPrimary,
                      borderRadius: BorderRadius.circular(50)),
                  child: TextWidget(AppConstants.str_start_a_room,
                      color: AppConstants.clrWhite,
                      fontSize: AppConstants.size_extra_small,
                      fontWeight: FontWeight.bold),
                ),
              ),
              flex: 2),
          Flexible(
              child: tabWidget(context, TabItemMain.upcoming,
                  AppConstants.ic_upcoming, AppConstants.str_tab_upcoming),
              flex: 1),
          Flexible(
              child: tabWidget(context, TabItemMain.active,
                  AppConstants.ic_active, AppConstants.str_tab_active),
              flex: 1),
        ],
      ),
    );
  }

  Widget tabWidget(BuildContext context, TabItemMain itemMain, String ic,
      String appBarName) {
    return GestureDetector(
      onTap: () {
        appbarName = appBarName;
        onTabClick(itemMain);
      },
      child: GestureDetector(
        child: Container(
          height: 50,
          color: AppConstants.clrWhite,
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 50,
                width: 100,
                alignment: Alignment.center,
                child: Image.asset(
                  ic,
                  height: 18,
                  width: 18,
                  color: (itemMain == currentTab)
                      ? AppConstants.clrBlack
                      : AppConstants.clrDarkGrey,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          appbarName = appBarName;
          onTabClick(itemMain);
        },
      ),
    );
  }

  onTabClick(TabItemMain itemMain) async {
    setState(() {
      currentTab = itemMain;
    });
  }
}
