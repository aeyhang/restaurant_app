import 'package:get/get.dart';
import '../models/category.dart';
import '../services/category_service.dart';

class CategoryController extends GetxController {
  static CategoryController instance=Get.find();
  var categories=<Category>[].obs;
  var selectedCat=Category(id: 0,catName: 'none',description: 'none').obs;
  void setSelected(Category cat){
    selectedCat.value=cat;
  }
  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  
  void fetchCategories() async {
    categories.value = await CategoryService.getCategories();
    update();
  }
}
