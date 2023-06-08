import 'image_model.dart';

List<StepModel> foodsFromJson(dynamic str) =>
    List<StepModel>.from((str).map((x) => StepModel.fromJson(x)));

class StepModel {
  late String? stepId;
  late String? implementationGuide;
  late List<ImageModel>? image;

  StepModel({
    this.stepId,
    this.implementationGuide,
    this.image,
    
  });

  StepModel.fromJson(Map<String, dynamic> json) {
    stepId = json['step_id'];
    implementationGuide = json['implementation_guide'];
    if (json['step_image'] != null && json['step_image'] is List) {
      image = List<ImageModel>.from(
        json['step_image'].map((x) => ImageModel.fromJson(x)),
      );
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['step_id'] = stepId;
    data['implementation_guide'] = implementationGuide;
    if (image != null) {
      data['step_image'] = image!.map((x) => x.toJson()).toList();
    }
    return data;
  }
}
