// user_id, user_name, email, password, birthday, avatar, address, phone, accessChangePassword, refresh_token, role_id, status

List<CategoryModel> categoriesFromJson(dynamic str) =>
    List<CategoryModel>.from((str).map((x) => CategoryModel.fromJson(x)));

class CategoryModel {
  late String? cateId;
  late String? cateName;
  late String? status;

  CategoryModel({
    this.cateId,
    this.cateName,
    this.status,
    
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    cateId = json['cate_id'];
    cateName = json['cate_name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cate_id'] = cateId;
    _data['cate_name'] = cateName;
    _data['status'] = status;
    return _data;
  }
}
