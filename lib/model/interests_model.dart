class InterestsCategoryModel {
  String categoryName;
  List<InterestsModel> interestsModels =[];

  InterestsCategoryModel(this.categoryName, this.interestsModels);
}

class InterestsModel {
  String name;
  bool isSelected;
  String description;

  InterestsModel(this.name, this.isSelected, {this.description});
}
