import 'dart:convert';

import 'package:intl/intl.dart';

List<ArticlesModel> postsFromJson(String str) => List<ArticlesModel>.from(
    json.decode(str).map((x) => ArticlesModel.formJson(x)));

ArticlesModel postDetailsFromJson(String str) =>
    ArticlesModel.formJson(json.decode(str));

class ArticlesModel {
  int? id;
  String? title;
  String? postedDate;
  int? categoryId;
  String? postContent;
  String? href;
  String? aoutherLink;
  String? link;
  String? categoryInfoHref;

  ArticlesModel({
    this.id,
    this.title,
    this.postedDate,
    this.categoryId,
    this.postContent,
    this.href,
    this.aoutherLink,
    this.link,
    this.categoryInfoHref,
  });

  ArticlesModel.formJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title']['rendered'];
    postedDate = DateFormat("dd-MM-yyyy").format(
      DateTime.parse(
        json['date'],
      ),
    );
    categoryId = json['categories'][0];
    if (json['content']['rendered'] != null) {
      postContent = json['content']['rendered'];
    }
    // to get image path
    href = json['_links']['wp:featuredmedia'][0]['href'];
    aoutherLink = json['_links']['author'][0]['href'];
    link = json['link'];
    categoryInfoHref = json['_links']['wp:term'][0]['href'];
  }
}
