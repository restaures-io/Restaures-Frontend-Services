import 'package:restaures/components/Global/api_response.dart';
import 'package:restaures/utils/api_service.dart';

class EnquiryService {
  static ApiService _apiService = ApiService();
  static Future<ApiResponse> sendEnquiry(
      String menuId, int quantity, int totalPrice) async {
    return await _apiService.post('customer/enquiry',
        {"menuId": menuId, "quantity": quantity, "totalPrice": totalPrice});
  }

  static Future<ApiResponse> getCustomerEnquiries() async {
    return await _apiService.get('customer/enquiry');
  }

  static Future<ApiResponse> getRestaurantEnquiries() async {
    return await _apiService.get('restaurant/enquiry');
  }

  static Future<ApiResponse> updateEnquiryStatus(
      String enquiryId, String status, int timeToPrepare) async {
    return await _apiService.put('restaurant/enquiry/status/$enquiryId', {
      "status": status,
      "timeToPrepare": timeToPrepare,
    });
  }

  static Future<ApiResponse> updateEnquiryCustomerStatus(
      String enquiryId, String status, int timeToPrepare) async {
    return await _apiService.put('customer/enquiry/status/$enquiryId', {
      "status": status,
      "timeToPrepare": timeToPrepare,
    });
  }
}
