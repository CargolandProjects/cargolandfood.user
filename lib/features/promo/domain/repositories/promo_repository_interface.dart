import 'package:stackfood_multivendor/features/promo/domain/models/promo_status_model.dart';
import 'package:stackfood_multivendor/interface/repository_interface.dart';

abstract class PromoRepositoryInterface extends RepositoryInterface {
  Future<PromoStatusModel?> getStatus();
  Future<bool> markSeen();
}
