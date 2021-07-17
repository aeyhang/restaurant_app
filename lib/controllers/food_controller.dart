import 'package:get/get.dart';
import '../models/food.dart';
import '../services/food_service.dart';

class FoodController extends GetxController {
  static FoodController instance=Get.find();
  var foods=<Food>[].obs;
  var food=Food(id: 0,foodName: 'none',unitId: 1,categoryId: 1,foodPrice: 0.0,foodStatus: 0,updateStock: 0).obs;
  var isButtonEnable=true.obs;
  
  @override
  void onInit() {
    // print('printing from table controller class');flu
    fetchFood();
    super.onInit();
  }
  Future<String>addFood(Food food)async{
    final result=await FoodService.postFood(food);
    fetchFood();
    return result;
  }
 Future<String> updateFood(Food food) async{
   final result=await FoodService.updateFood(food);
   fetchFood();
   return result;
 }
  
  void fetchFood() async {
    foods.value = await FoodService.getFoods();
    update();
  }
}
