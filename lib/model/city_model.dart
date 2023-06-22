// user_id, user_name, email, password, birthday, avatar, address, phone, accessChangePassword, refresh_token, role_id, status

List<CityModel> citiesFromJson(dynamic str) =>
    List<CityModel>.from((str).map((x) => CityModel.fromJson(x)));

class CityModel {
  late String? cityId;
  late String? cityName;
  late String? status;

  CityModel({
    this.cityId,
    this.cityName,
    this.status,
  });

  CityModel.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    cityName = json['city_name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['city_id'] = cityId;
    data['city_name'] = cityName;
    data['status'] = status;
    return data;
  }
}
