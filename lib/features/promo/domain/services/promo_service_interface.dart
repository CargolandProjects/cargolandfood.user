import 'package:stackfood_multivendor/features/promo/domain/models/promo_status_model.dart';

abstract class PromoServiceInterface {
  Future<PromoStatusModel?> getStatus();
  Future<bool> markSeen();
}
