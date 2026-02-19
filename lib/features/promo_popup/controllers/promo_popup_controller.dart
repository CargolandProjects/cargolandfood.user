import 'package:get/get.dart';
import 'package:stackfood_multivendor/features/promo_popup/domain/models/promo_popup_model.dart';
import 'package:stackfood_multivendor/features/promo_popup/domain/services/promo_popup_service_interface.dart';

class PromoPopupController extends GetxController implements GetxService {
  final PromoPopupServiceInterface promoPopupServiceInterface;
  PromoPopupController({required this.promoPopupServiceInterface});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<PromoPopupModel?> getNextPopup() async {
    if (_isLoading) {
      return null;
    }
    _isLoading = true;
    final PromoPopupModel? popup = await promoPopupServiceInterface
        .getNextPopup();
    _isLoading = false;
    return popup;
  }

  Future<void> sendPopupEvent({
    required int impressionId,
    required String event,
  }) async {
    await promoPopupServiceInterface.sendPopupEvent(
      impressionId: impressionId,
      event: event,
    );
  }
}
