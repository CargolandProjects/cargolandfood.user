import 'package:stackfood_multivendor/features/promo_popup/domain/models/promo_popup_model.dart';
import 'package:stackfood_multivendor/features/promo_popup/domain/repositories/promo_popup_repository_interface.dart';
import 'package:stackfood_multivendor/features/promo_popup/domain/services/promo_popup_service_interface.dart';

class PromoPopupService implements PromoPopupServiceInterface {
  final PromoPopupRepositoryInterface promoPopupRepositoryInterface;
  PromoPopupService({required this.promoPopupRepositoryInterface});

  @override
  Future<PromoPopupModel?> getNextPopup() async {
    return await promoPopupRepositoryInterface.getNextPopup();
  }

  @override
  Future<bool> sendPopupEvent({
    required int impressionId,
    required String event,
  }) async {
    if (event != 'clicked' && event != 'dismissed') {
      return false;
    }
    return await promoPopupRepositoryInterface.sendPopupEvent(
      impressionId: impressionId,
      event: event,
    );
  }
}
