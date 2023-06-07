import 'category_model.dart';

List<CategoryDetailModel> categoryDetailFromJson(dynamic str) {

  final rows = str['rows'];

  return List<CategoryDetailModel>.from(rows.map((x) => CategoryDetailModel.fromJson(x)));
}
class CategoryDetailModel {
  late String? cateDetailId;
  late String? cateDetailName;
  late CategoryModel? categoryModel;
  late String? status;

  CategoryDetailModel({
    this.cateDetailId,
    this.cateDetailName,
    this.categoryModel,
    this.status,
    
  });

  CategoryDetailModel.fromJson(Map<String, dynamic> json) {
  cateDetailId = json['cate_detail_id'];
  cateDetailName = json['cate_detail_name'];
  categoryModel = json['category_model'] != null
      ? CategoryModel.fromJson(json['category_model'])
      : null;
  status = json['status'];
}


  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['cate_detail_id'] = cateDetailId;
    data['cate_detail_name'] = cateDetailName;
    if (categoryModel != null) {
      data['category_model'] = categoryModel!.toJson();
    }

    data['status'] = status;
    return data;
  }
}
