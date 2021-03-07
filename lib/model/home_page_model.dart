class HomeModel{
  String title;
  String time;
  String detail;
      HomeModel(this.title,this.time,this.detail);

}


class PostListModel{
  String home;
  String detail;
  List<UserListModel> userListModel;
  String spikerCounter;
  String userCounter;

  PostListModel(this.home, this.detail, this.userListModel,this.spikerCounter,this.userCounter);
}

class UserListModel{
  String profile;
  String name;
  UserListModel(this.profile,this.name);


}