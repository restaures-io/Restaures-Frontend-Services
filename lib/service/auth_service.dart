import 'package:restaures/components/Global/api_constants.dart';
import 'package:restaures/components/Global/api_response.dart';
import 'package:restaures/utils/api_service.dart';

class AuthService {
  static final ApiService _apiService = ApiService();

  static Future<ApiResponse> loginRestaurant(
      String email, String password) async {
    return await _apiService
        .post(ApiUrl.restaurantLogin, {'email': email, 'password': password});
  }

  static Future<ApiResponse> loginCustomer(
      String email, String password) async {
    return await _apiService
        .post(ApiUrl.customerLogin, {'email': email, 'password': password});
  }

  static Future<ApiResponse> registerCustomer(
      {required String firstName,
      required String lastName,
      required String email,
      required String phone,
      required String password}) async {
    return await _apiService.post(ApiUrl.customerRegister, {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phone,
      'password': password,
    });
  }
}
