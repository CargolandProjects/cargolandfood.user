import 'package:stackfood_multivendor/features/promo_popup/domain/models/promo_popup_model.dart';

abstract class PromoPopupServiceInterface {
  Future<PromoPopupModel?> getNextPopup();
  Future<bool> sendPopupEvent({
    required int impressionId,
    required String event,
  });
}
