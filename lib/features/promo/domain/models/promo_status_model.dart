class PromoStatusModel {
  bool? active;
  bool? bannerRequired;
  int? promoOrderCount;
  bool? cokeEligible;
  bool? freeDeliveryEligible;
  String? promoWindowStart;
  String? promoWindowEnd;
  PromoBannerModel? banner;

  PromoStatusModel({
    this.active,
    this.bannerRequired,
    this.promoOrderCount,
    this.cokeEligible,
    this.freeDeliveryEligible,
    this.promoWindowStart,
    this.promoWindowEnd,
    this.banner,
  });

  PromoStatusModel.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    bannerRequired = json['banner_required'];
    promoOrderCount = json['promo_order_count'];
    cokeEligible = json['coke_eligible'];
    freeDeliveryEligible = json['free_delivery_eligible'];
    promoWindowStart = json['promo_window_start'];
    promoWindowEnd = json['promo_window_end'];
    banner = json['banner'] != null ? PromoBannerModel.fromJson(json['banner']) : null;
  }
}

class PromoBannerModel {
  String? title;
  String? subtitle;
  String? cta;
  String? image;

  PromoBannerModel({this.title, this.subtitle, this.cta, this.image});

  PromoBannerModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    cta = json['cta'];
    image = json['image'];
  }
}
