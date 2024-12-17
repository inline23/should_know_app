import 'dart:convert';

List<CategoryModel> categoryFromJson(String str) => List<CategoryModel>.from(
      json.decode(str).map(
            (x) => CategoryModel.fromJson(x),
          ),
    );

class CategoryModel {
  int? categoryId;
  String? categoryName;
  int? count;
  CategoryModel({this.categoryId, this.categoryName, this.count});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['id'];
    categoryName = json['name'];
    count = json['count'];
  }
}
