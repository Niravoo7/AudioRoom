import 'package:audioroom/firestore/model/room_model.dart';

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

class StartRoomModel {
  List<String> peopleList;
  String roomName;
  String roomDesc;
  String roomType;
  RoomModel roomModel;

  StartRoomModel(this.peopleList, this.roomName, this.roomDesc, this.roomType,
      this.roomModel);
}
