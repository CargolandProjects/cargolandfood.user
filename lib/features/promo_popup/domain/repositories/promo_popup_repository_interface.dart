import 'package:stackfood_multivendor/features/promo_popup/domain/models/promo_popup_model.dart';
import 'package:stackfood_multivendor/interface/repository_interface.dart';

abstract class PromoPopupRepositoryInterface extends RepositoryInterface {
  Future<PromoPopupModel?> getNextPopup();
  Future<bool> sendPopupEvent({
    required int impressionId,
    required String event,
  });
}
