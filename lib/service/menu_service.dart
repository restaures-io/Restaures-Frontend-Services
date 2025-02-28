import 'package:restaures/components/Global/api_constants.dart';
import 'package:restaures/components/Global/api_response.dart';
import 'package:restaures/model/menu_item.dart';
import 'package:restaures/utils/api_service.dart';

class MenuService {
  static final ApiService _apiService = ApiService();

  static Future<ApiResponse> addMenu(MenuItem menuItem) async {
    return await _apiService.post(ApiUrl.addRestaurantMenu, menuItem.toJson());
  }

  static Future<ApiResponse> getMenu() async {
    return await _apiService.get(ApiUrl.getMenu);
  }

  static Future<ApiResponse> getRestaurantMenu(String restaurantId) async {
    return await _apiService.get('${ApiUrl.getRestaurantMenu}/$restaurantId');
  }

  static Future<ApiResponse> getMenuById(String menuId) async {
    return await _apiService.get('${ApiUrl.getMenu}/$menuId');
  }
}
