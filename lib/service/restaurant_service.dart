import 'package:restaures/components/Global/api_constants.dart';
import 'package:restaures/components/Global/api_response.dart';
import 'package:restaures/model/restaurant.dart';
import 'package:restaures/utils/api_service.dart';

class RestaurantService {
  static ApiService _apiService = ApiService();

  static Future<List<RestaurantModel>> getAllRestaurant() async {
    ApiResponse response = await _apiService.get(ApiUrl.getAllRestaurant);
    List<RestaurantModel> restaurants = [];
    if (response.success) {
      response.data.forEach((restaurant) {
        restaurants.add(RestaurantModel.fromJson(restaurant));
      });
    }
    return restaurants;
  }

  static Future<RestaurantModel> getRestaurantById(String id) async {
    ApiResponse response = await _apiService.get(ApiUrl.getRestaurantById + id);
    return RestaurantModel.fromJson(response.data);
  }

  static Future<ApiResponse> putFavoriteRestaurant(String restaurantId) async {
    return await _apiService
        .put('${ApiUrl.apiFavoriteRestaurants}/$restaurantId', {});
  }

  static Future<ApiResponse> getFavoriteRestaurants() async {
    return await _apiService.get(ApiUrl.apiFavoriteRestaurants);
  }

  static Future<ApiResponse> deleteFavoriteRestaurant(
      String restaurantId) async {
    return await _apiService
        .delete('${ApiUrl.apiFavoriteRestaurants}/$restaurantId', body: {});
  }
}
