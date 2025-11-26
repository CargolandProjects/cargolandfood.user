import 'package:get/get.dart';
import 'package:stackfood_multivendor/api/api_client.dart';
import 'package:stackfood_multivendor/features/promo/domain/models/promo_status_model.dart';
import 'package:stackfood_multivendor/features/promo/domain/repositories/promo_repository_interface.dart';
import 'package:stackfood_multivendor/util/app_constants.dart';

class PromoRepository implements PromoRepositoryInterface {
  final ApiClient apiClient;
  PromoRepository({required this.apiClient});

  @override
  Future<PromoStatusModel?> getStatus() async {
    PromoStatusModel? status;
    Response response = await apiClient.getData(AppConstants.promoStatusUri, handleError: false);
    if (response.statusCode == 200) {
      status = PromoStatusModel.fromJson(response.body);
    }
    return status;
  }

  @override
  Future<bool> markSeen() async {
    Response response = await apiClient.postData(AppConstants.promoSeenUri, {}, handleError: false);
    return response.statusCode == 200;
  }

  @override
  Future getList({int? offset}) {
    throw UnimplementedError();
  }

  @override
  Future add(value) {
    throw UnimplementedError();
  }

  @override
  Future delete(int? id) {
    throw UnimplementedError();
  }

  @override
  Future get(String? id) {
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int? id) {
    throw UnimplementedError();
  }
}
