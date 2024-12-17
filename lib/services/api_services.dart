import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:should_know_app/config.dart';
import 'package:should_know_app/model/articles_model.dart';
import 'package:should_know_app/model/category_model.dart';

class APIService {
  static var client = http.Client();

  static Future<List<CategoryModel>?> fetchCategories() async {
      var response = await client.get(Uri.parse(
        Config.apiURL + Config.categoryURL,
      ));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        return categoryFromJson(jsonString);
      } else {
        return null;
      }
  }

  //##################################################################################

  static Future<List<ArticlesModel>?> fetchPosts(int categoryId) async {
      //print("POSTS API");
      var response = await client.get(
          Uri.parse(Config.apiURL + Config.postsURL + categoryId.toString()));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        return postsFromJson(jsonString);
      } else {
        return null;
      }
  }

//##################################################################
  static Future fetchWpPostImageUrl(String href) async {
    try {
      // Perform the GET request
      final response = await http.get(Uri.parse(href));
      if (response.statusCode == 200) {
        var convertedDatatoJson = jsonDecode(response.body);
        return convertedDatatoJson;
      } else {
        //print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //print('An error occurred: $e');
    }
    }

    static Future fetchAoutherName(String href) async {
    try {
      // Perform the GET request
      final response = await http.get(Uri.parse(href));
      if (response.statusCode == 200) {
        var convertedDatatoJson = jsonDecode(response.body);
        return convertedDatatoJson;
      } else {
        //print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //print('An error occurred: $e');
    }
    }

    static Future fetchCategoryName(String href) async {
    try {
      // Perform the GET request
      final response = await http.get(Uri.parse(href));
      if (response.statusCode == 200) {
        var convertedDatatoJson = jsonDecode(response.body);
        return convertedDatatoJson;
      } else {
        //print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //print('An error occurred: $e');
    }
    }

}