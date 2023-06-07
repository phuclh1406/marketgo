// user_id, user_name, email, password, birthday, avatar, address, phone, accessChangePassword, refresh_token, role_id, status

List<CategoryModel> categoriesFromJson(dynamic str) {
  if(str == null || str is! Map) {
    return [];
  }

  final rows = str['rows'];

  if(rows == null || rows is! Iterable) {
    return [];
  }

  return List<CategoryModel>.from(rows.map((x) => CategoryModel.fromJson(x)));
}

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
    final data = <String, dynamic>{};
    data['cate_id'] = cateId;
    data['cate_name'] = cateName;
    data['status'] = status;
    return data;
  }
}
