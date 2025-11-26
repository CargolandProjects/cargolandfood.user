import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackfood_multivendor/features/promo/domain/models/promo_status_model.dart';
import 'package:stackfood_multivendor/features/promo/domain/services/promo_service_interface.dart';
import 'package:stackfood_multivendor/features/promo/widgets/promo_banner_dialog.dart';
import 'package:stackfood_multivendor/helper/auth_helper.dart';

class PromoController extends GetxController implements GetxService {
  final PromoServiceInterface promoServiceInterface;
  PromoController({required this.promoServiceInterface});

  PromoStatusModel? _status;
  bool _isLoading = false;
  bool _isDialogShowing = false;

  PromoStatusModel? get status => _status;
  bool get isLoading => _isLoading;

  Future<void> loadStatus() async {
    if (!AuthHelper.isLoggedIn()) {
      return;
    }
    _isLoading = true;
    update();
    _status = await promoServiceInterface.getStatus();
    _isLoading = false;
    update();
  }

  Future<void> markBannerSeen() async {
    if (!AuthHelper.isLoggedIn()) {
      return;
    }
    bool success = await promoServiceInterface.markSeen();
    if (success && _status != null) {
      _status!.bannerRequired = false;
      update();
    }
  }

  Future<void> checkAndShowBanner(BuildContext context) async {
    await loadStatus();
    if (shouldShowBanner && !_isDialogShowing) {
      _isDialogShowing = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => PromoBannerDialog(status: _status!),
        ).then((value) {
          _isDialogShowing = false;
        });
      });
    }
  }

  bool get shouldShowBanner => (_status?.active ?? false) && (_status?.bannerRequired ?? false);
  bool get freeDeliveryEligible => _status?.freeDeliveryEligible ?? false;
  int get promoOrderCount => _status?.promoOrderCount ?? 0;
}
