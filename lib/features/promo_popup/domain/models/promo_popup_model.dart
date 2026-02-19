class PromoPopupModel {
  int? campaignId;
  int? impressionId;
  String? campaignType;
  String? title;
  String? shortDescription;
  String? image;
  String? imageFullUrl;
  String? startAt;
  String? endAt;
  bool? popupEnabled;
  int? popupMinIntervalHours;
  int? popupMinIntervalMinutes;
  int? popupMaxImpressionsPerDay;
  int? popupMaxTotalImpressions;

  PromoPopupModel({
    this.campaignId,
    this.impressionId,
    this.campaignType,
    this.title,
    this.shortDescription,
    this.image,
    this.imageFullUrl,
    this.startAt,
    this.endAt,
    this.popupEnabled,
    this.popupMinIntervalHours,
    this.popupMinIntervalMinutes,
    this.popupMaxImpressionsPerDay,
    this.popupMaxTotalImpressions,
  });

  PromoPopupModel.fromJson(Map<String, dynamic> json) {
    campaignId = int.tryParse(json['campaign_id'].toString());
    impressionId = int.tryParse(json['impression_id'].toString());
    campaignType = json['campaign_type'];
    title = json['title'];
    shortDescription = json['short_description'];
    image = json['image'];
    imageFullUrl = json['image_full_url'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    popupEnabled =
        json['popup_enabled'] == true ||
        json['popup_enabled'] == 1 ||
        json['popup_enabled'] == '1';
    popupMinIntervalHours = int.tryParse(json['popup_min_interval_hours'].toString());
    popupMinIntervalMinutes = int.tryParse(json['popup_min_interval_minutes'].toString());
    popupMinIntervalMinutes ??=
        popupMinIntervalHours != null ? (popupMinIntervalHours! * 60) : null;
    popupMaxImpressionsPerDay = int.tryParse(
      json['popup_max_impressions_per_day'].toString(),
    );
    popupMaxTotalImpressions = int.tryParse(
      json['popup_max_total_impressions'].toString(),
    );
  }
}
