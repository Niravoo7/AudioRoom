class YourRoomCardModel {
  String title;
  String detail;
  List<YourRoomCardPeopleModel> yourRoomCardPeopleModels;
  String speakerCounter;
  String userCounter;

  YourRoomCardModel(this.title, this.detail, this.yourRoomCardPeopleModels,
      this.speakerCounter, this.userCounter);
}

class YourRoomCardPeopleModel {
  String profile;
  String name;
  bool isStar;
  bool isMute;

  YourRoomCardPeopleModel(this.profile, this.name, this.isStar, this.isMute);
}
