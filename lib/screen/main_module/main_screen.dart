import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/helper/navigate_effect.dart';
import 'package:audioroom/helper/validate.dart';
import 'package:audioroom/model/room_card_model.dart';
import 'package:audioroom/screen/main_module/active_user_module/active_user_screen.dart';
import 'package:audioroom/screen/main_module/home_module/home_screen.dart';
import 'package:audioroom/screen/main_module/room_module/start_room_screen.dart';
import 'package:audioroom/screen/main_module/search_module/search_screen.dart';
import 'package:audioroom/screen/main_module/upcoming_module/upcoming_screen.dart';
import 'package:audioroom/screen/main_module/room_module/your_room_screen.dart';
import 'package:audioroom/screen/main_module/profile_module/profile_screen.dart';
import 'package:audioroom/screen/main_module/notification_module/notification_screen.dart';
import 'package:audioroom/screen/main_module/invite_module/invite_screen.dart';
import 'package:audioroom/custom_widget/flexible_widget.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:audioroom/screen/main_module/search_module/conversations_screen.dart';

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

  bool isRoomSmallVisible = false;
  bool isRoomLargeVisible = false;

  List<String> icons = [];

  @override
  void initState() {
    super.initState();

    homeScreen = new HomeScreen();
    searchScreen = new SearchScreen(callConversationsScreen);
    startRoomScreen = new StartRoomScreen(callYourRoomScreen);
    upcomingScreen = new UpcomingScreen();
    activeUserScreen = new ActiveUserScreen();

    currentTab = TabItemMain.room;

    icons.add(AppConstants.ic_leave_group);
    icons.add(AppConstants.ic_list);
    icons.add(AppConstants.ic_add_user);
    icons.add(AppConstants.ic_speaker);
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
          await navigatorKeys[currentTab].currentState.maybePop();
        }
        return false;
      },
      child: Scaffold(
        appBar: (currentTab != TabItemMain.room)
            ? AppBar(
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
                              Navigator.push(
                                  context,
                                  NavigatePageRoute(
                                      context, NotificationScreen()));
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
                              Navigator.push(
                                  context,
                                  NavigatePageRoute(
                                      context, ProfileScreen(false)));
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            : null,
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
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    (isRoomSmallVisible)
                        ? icRoomSmallBottomSheet()
                        : Container(),
                    (isRoomLargeVisible)
                        ? icRoomLargeBottomSheet()
                        : Container(),
                    bottomBar(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget icRoomSmallBottomSheet() {
    return Container(
      padding: EdgeInsets.only(bottom: 60, top: 16, left: 16, right: 16),
      decoration: BoxDecoration(
          color: AppConstants.clrWhite,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          border: Border.all(color: AppConstants.clrSearchBG, width: 1)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          child: Icon(
            Icons.keyboard_arrow_up,
            size: 30,
            color: AppConstants.clrBlack,
          ),
        ),
        Stack(
          children: [
            Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                  border: Border.all(color: AppConstants.clrWhite, width: 1),
                  image: DecorationImage(
                      image: AssetImage(AppConstants.ic_user_profile)),
                  shape: BoxShape.circle),
            ),
            Container(
              height: 28,
              width: 28,
              margin: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: AppConstants.clrWhite, width: 1),
                  image: DecorationImage(
                      image: AssetImage(AppConstants.ic_user_profile2)),
                  shape: BoxShape.circle),
            ),
            Container(
              height: 28,
              width: 28,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 40),
              decoration: BoxDecoration(
                  color: AppConstants.clrSearchBG,
                  border: Border.all(color: AppConstants.clrWhite, width: 1),
                  shape: BoxShape.circle),
              child: TextWidget("+132",
                  color: AppConstants.clrBlack,
                  fontSize: AppConstants.size_double_extra_small),
            )
          ],
        ),
        FlexibleWidget(1),
        Container(
            height: 36,
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: icons.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Container(
                      padding: EdgeInsets.only(top: 8, bottom: 8, left: 20),
                      child: Image.asset(icons[index], height: 20),
                    ),
                    onTap: () {
                      switch (icons[index]) {
                        case AppConstants.ic_leave_group:
                          break;
                        case AppConstants.ic_list:
                          break;
                        case AppConstants.ic_add_user:
                          break;
                        case AppConstants.ic_speaker:
                          break;
                      }
                    },
                  );
                }))
      ]),
    );
  }

  Widget icRoomLargeBottomSheet() {
    List<RoomCardPeopleModel> roomCardPeopleModels =
    [];
    roomCardPeopleModels.add(
        RoomCardPeopleModel(AppConstants.ic_user_profile, "Melinda Livsey"));
    roomCardPeopleModels
        .add(RoomCardPeopleModel(AppConstants.ic_user_profile2, "Ben Bhai"));
    roomCardPeopleModels.add(
        RoomCardPeopleModel(AppConstants.ic_user_profile, "Melinda Livsey"));
    roomCardPeopleModels
        .add(RoomCardPeopleModel(AppConstants.ic_user_profile2, "Ben Bhai"));
    roomCardPeopleModels.add(
        RoomCardPeopleModel(AppConstants.ic_user_profile, "Melinda Livsey"));

    RoomCardModel roomCardModel = new RoomCardModel(
        "TheFutur",
        "Take The Guess Work Out Of Bidding - How To Bid",
        roomCardPeopleModels,
        "5",
        "132");

    double crossAxisSpacing = 10;
    double mainAxisSpacing = 10;
    double screenWidth = MediaQuery.of(context).size.width - 35;
    int crossAxisCount = 3;
    double width = (screenWidth - ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;
    double cellHeight = 40;
    double aspectRatio = width / cellHeight;

    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(bottom: 48, top: 16, left: 16, right: 16),
        decoration: BoxDecoration(
            color: AppConstants.clrWhite,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            border: Border.all(color: AppConstants.clrSearchBG, width: 1)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 8),
                    child: Image.asset(
                      AppConstants.ic_dark_home,
                      height: 18,
                      width: 18,
                      color: AppConstants.clrBlack,
                    ),
                  ),
                  TextWidget(roomCardModel.title,
                      color: AppConstants.clrBlack,
                      fontSize: AppConstants.size_small_medium,
                      fontWeight: FontWeight.normal),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 8),
                    child: Image.asset(
                      AppConstants.ic_clock,
                      height: 18,
                      width: 18,
                      color: AppConstants.clrBlack,
                    ),
                  ),
                  TextWidget('Tomorrow at 3:30 PM',
                      color: AppConstants.clrBlack,
                      fontSize: AppConstants.size_small_medium,
                      fontWeight: FontWeight.normal),
                ],
              ),
              Image.asset(
                AppConstants.ic_notification,
                height: 18,
                width: 18,
                color: AppConstants.clrBlack,
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 13),
            child: TextWidget(roomCardModel.detail,
                color: AppConstants.clrBlack,
                fontSize: AppConstants.size_medium_large,
                fontWeight: FontWeight.w600,
                maxLines: 2),
          ),
          GridView.builder(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: crossAxisSpacing,
                  mainAxisSpacing: mainAxisSpacing,
                  childAspectRatio: aspectRatio),
              itemCount: roomCardModel.userListModel.length,
              itemBuilder: (context, index1) {
                return Row(
                  children: [
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(right: 5),
                        height: 33,
                        width: 36,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: AppConstants.clrTransparent,
                            image: DecorationImage(
                                image: AssetImage(roomCardModel
                                    .userListModel[index1].profile),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Flexible(
                      child: TextWidget(
                          roomCardModel.userListModel[index1].name,
                          color: AppConstants.clrBlack,
                          fontSize: AppConstants.size_small_medium,
                          fontWeight: FontWeight.normal,
                          textOverflow: TextOverflow.ellipsis),
                    ),
                  ],
                );
              }),
          DividerWidget(height: 1),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: AppConstants.clrTransparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
                              child: Image.asset(AppConstants.ic_share,
                                  height: 20)),
                          TextWidget(AppConstants.str_share,
                              color: AppConstants.clrBlack,
                              fontSize: AppConstants.size_small_medium,
                              fontWeight: FontWeight.bold,
                              maxLines: 1),
                          SizedBox(height: 16)
                        ],
                      ),
                    ),
                    Container(
                      color: AppConstants.clrTransparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
                              child: Image.asset(AppConstants.ic_twitter,
                                  height: 20)),
                          TextWidget(AppConstants.str_tweet,
                              color: AppConstants.clrBlack,
                              fontSize: AppConstants.size_small_medium,
                              fontWeight: FontWeight.bold,
                              maxLines: 1),
                          SizedBox(height: 16)
                        ],
                      ),
                    ),
                    Container(
                      color: AppConstants.clrTransparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
                              child: Image.asset(AppConstants.ic_copy_link,
                                  height: 20)),
                          TextWidget(AppConstants.str_copy_link,
                              color: AppConstants.clrBlack,
                              fontSize: AppConstants.size_small_medium,
                              fontWeight: FontWeight.bold,
                              maxLines: 1),
                          SizedBox(height: 16)
                        ],
                      ),
                    ),
                    Container(
                      color: AppConstants.clrTransparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
                              child: Image.asset(AppConstants.ic_add_to_call,
                                  height: 20)),
                          TextWidget(AppConstants.str_add_to_call,
                              color: AppConstants.clrBlack,
                              fontSize: AppConstants.size_small_medium,
                              fontWeight: FontWeight.bold,
                              maxLines: 1),
                          SizedBox(height: 16)
                        ],
                      ),
                    )
                  ]))
        ]));
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
      decoration: BoxDecoration(
          color: AppConstants.clrWhite,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          border: Border.all(color: AppConstants.clrDivider, width: 1)),
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
          color: AppConstants.clrTransparent,
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

  void callConversationsScreen() {
    Navigator.push(context, NavigatePageRoute(context, ConversationsScreen()));
  }

  void callYourRoomScreen() {
    Navigator.push(context, NavigatePageRoute(context, YourRoomScreen()));
  }
}
