import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackfood_multivendor/features/promo/controllers/promo_controller.dart';
import 'package:stackfood_multivendor/features/promo/domain/models/promo_status_model.dart';
import 'package:stackfood_multivendor/util/dimensions.dart';
import 'package:stackfood_multivendor/util/styles.dart';

class PromoBannerDialog extends StatelessWidget {
  final PromoStatusModel status;
  const PromoBannerDialog({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final title = status.banner?.title ?? 'Order three times and get free Coke';
    final subtitle = status.banner?.subtitle ?? 'First three orders: free Coke. Fourth order: free delivery.';
    final cta = status.banner?.cta ?? 'Okay';
    final imageUrl = status.banner?.image;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusLarge)),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl != null && imageUrl.isNotEmpty) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                child: Image.network(
                  imageUrl,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeDefault),
            ],
            Text(title, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            Text(subtitle, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor)),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.find<PromoController>().markBannerSeen();
                  Navigator.of(context).pop();
                },
                child: Text(cta),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
