// user_id, user_name, email, password, birthday, avatar, address, phone, accessChangePassword, refresh_token, role_id, status

import 'dart:ffi';

List<PromotionModel> promotionsFromJson(dynamic str) =>
    List<PromotionModel>.from((str).map((x) => PromotionModel.fromJson(x)));

class PromotionModel {
  late String? promotionId;
  late String? promotionName;
  late String? description;
  late double? discount;
  late DateTime? startTime;
  late DateTime? endTime;
  late String? status;

  PromotionModel({
    this.promotionId,
    this.promotionName,
    this.description,
    this.discount,
    this.startTime,
    this.endTime,
    this.status,
    
  });

  PromotionModel.fromJson(Map<String, dynamic> json) {
    promotionId = json['promotion_id'];
    promotionName = json['promotion_name'];
    description = json['description'];
    discount = json['discount'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['promotion_id'] = promotionId;
    data['promotion_name'] = promotionName;
    data['description'] = description;
    data['discount'] = discount;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['status'] = status;
    return data;
  }
}
