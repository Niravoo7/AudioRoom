import 'package:audioroom/firestore/model/user_model.dart';

class ChoosePeopleModel {
  UserModel userModel;
  bool isOnline;
  bool isSelected;

  ChoosePeopleModel(this.userModel, this.isOnline, this.isSelected);
}
