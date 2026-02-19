import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:stackfood_multivendor/api/api_client.dart';
import 'package:stackfood_multivendor/features/promo_popup/domain/models/promo_popup_model.dart';
import 'package:stackfood_multivendor/features/promo_popup/domain/repositories/promo_popup_repository_interface.dart';
import 'package:stackfood_multivendor/util/app_constants.dart';

class PromoPopupRepository implements PromoPopupRepositoryInterface {
  final ApiClient apiClient;
  PromoPopupRepository({required this.apiClient});

  @override
  Future<PromoPopupModel?> getNextPopup() async {
    if (kDebugMode) {
      debugPrint('PROMO_POPUP: API Call => ${AppConstants.promoPopupNextUri}');
    }
    Response response = await apiClient.getData(
      AppConstants.promoPopupNextUri,
      handleError: false,
    );
    if (kDebugMode) {
      debugPrint('PROMO_POPUP: API Response [${response.statusCode}]');
    }
    if (response.statusCode == 200 && response.body is Map<String, dynamic>) {
      final dynamic popupData = response.body['popup'];
      if (popupData is Map<String, dynamic>) {
        if (kDebugMode) {
          debugPrint('PROMO_POPUP: popup found campaign_id=${popupData['campaign_id']} impression_id=${popupData['impression_id']}');
        }
        return PromoPopupModel.fromJson(popupData);
      }
    }
    if (kDebugMode) {
      debugPrint('PROMO_POPUP: popup is null or invalid');
    }
    return null;
  }

  @override
  Future<bool> sendPopupEvent({
    required int impressionId,
    required String event,
  }) async {
    if (kDebugMode) {
      debugPrint('PROMO_POPUP: send event impression_id=$impressionId event=$event');
    }
    Response response = await apiClient.postData(
      AppConstants.promoPopupEventUri,
      {'impression_id': impressionId, 'event': event},
      handleError: false,
    );
    if (kDebugMode) {
      debugPrint('PROMO_POPUP: event response [${response.statusCode}]');
    }
    return response.statusCode == 200;
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
  Future getList({int? offset}) {
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int? id) {
    throw UnimplementedError();
  }
}
