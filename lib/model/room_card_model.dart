class HomeModel {
  String title;
  String time;
  String detail;

  HomeModel(this.title, this.time, this.detail);
}

class RoomCardModel {
  String title;
  String detail;
  List<RoomCardPeopleModel> userListModel;
  String speakerCounter;
  String userCounter;

  RoomCardModel(this.title, this.detail, this.userListModel, this.speakerCounter,
      this.userCounter);
}

class RoomCardPeopleModel {
  String profile;
  String name;

  RoomCardPeopleModel(this.profile, this.name);
}
