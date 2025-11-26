import 'package:stackfood_multivendor/features/promo/domain/models/promo_status_model.dart';
import 'package:stackfood_multivendor/features/promo/domain/repositories/promo_repository_interface.dart';
import 'package:stackfood_multivendor/features/promo/domain/services/promo_service_interface.dart';

class PromoService implements PromoServiceInterface {
  final PromoRepositoryInterface promoRepositoryInterface;
  PromoService({required this.promoRepositoryInterface});

  @override
  Future<PromoStatusModel?> getStatus() async {
    return await promoRepositoryInterface.getStatus();
  }

  @override
  Future<bool> markSeen() async {
    return await promoRepositoryInterface.markSeen();
  }
}
