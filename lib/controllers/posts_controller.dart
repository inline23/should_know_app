import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:should_know_app/model/articles_model.dart';
import 'package:should_know_app/services/api_services.dart';

class PostsController extends GetxController  {
  var isLoading = true.obs;
  var postsList = List<ArticlesModel>.empty(growable: true).obs;

  Future<void> fetchPosts({int categoryId = 1}) async {
    try {
      // عايز اعمل هنا كول ل get mthod تجبلي الصوره من اللينك من خلال
      isLoading(true);
      var posts = await APIService.fetchPosts(categoryId);
      postsList.clear();
      if (posts != null) {
        postsList.addAll(posts);
      }
    } finally {
      isLoading(false);
    }
  }
}
