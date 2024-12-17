import 'package:get/get.dart';
import 'package:should_know_app/model/category_model.dart';
import 'package:should_know_app/services/api_services.dart';

class CategoriesController extends GetxController {
  var isLoading = true.obs;
  var categoriesList =
      List<CategoryModel>.empty(growable: true).obs; // Non-nullable
  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading(true);
      var categories = await APIService.fetchCategories();
      if (categories!.isNotEmpty) {
        categoriesList.clear();
        categoriesList.addAll(categories);
      }
    } finally {
      isLoading(false);
    }
  }
}
