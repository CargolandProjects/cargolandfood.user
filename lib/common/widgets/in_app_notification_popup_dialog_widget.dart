import 'package:flutter/material.dart';
import 'package:stackfood_multivendor/common/widgets/custom_image_widget.dart';
import 'package:stackfood_multivendor/util/dimensions.dart';
import 'package:stackfood_multivendor/util/images.dart';
import 'package:stackfood_multivendor/util/styles.dart';

class InAppNotificationPopupDialogWidget extends StatelessWidget {
  final String title;
  final String body;
  final String? imageUrl;

  const InAppNotificationPopupDialogWidget({
    super.key,
    required this.title,
    required this.body,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(Dimensions.radiusExtraLarge)),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop('dismissed'),
              ),
            ),
            if ((imageUrl ?? '').isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                  child: CustomImageWidget(
                    image: imageUrl ?? '',
                    height: 170,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: Images.notificationPlaceholder,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                Dimensions.paddingSizeLarge,
                Dimensions.paddingSizeLarge,
                Dimensions.paddingSizeLarge,
                Dimensions.paddingSizeSmall,
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: robotoBold.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: Dimensions.fontSizeLarge,
                ),
              ),
            ),
            if (body.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                child: Text(
                  body,
                  textAlign: TextAlign.center,
                  style: robotoRegular.copyWith(
                    color: Theme.of(context).disabledColor,
                    fontSize: Dimensions.fontSizeDefault,
                  ),
                ),
              ),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                Dimensions.paddingSizeLarge,
                0,
                Dimensions.paddingSizeLarge,
                Dimensions.paddingSizeLarge,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop('dismissed'),
                      child: const Text('Dismiss'),
                    ),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop('clicked'),
                      child: const Text('Open'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
