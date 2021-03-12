class InterestsCategoryModel {
  String categoryName;
  List<InterestsModel> interestsModels = new List<InterestsModel>();

  InterestsCategoryModel(this.categoryName, this.interestsModels);
}

class InterestsModel {
  String name;
  bool isSelected;
  String description;

  InterestsModel(this.name, this.isSelected, {this.description});
}
