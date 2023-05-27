List<RoleModel> rolesFromJson(dynamic str) =>
    List<RoleModel>.from((str).map((x) => RoleModel.fromJson(x)));

class RoleModel {
  late String? roleId;
  late String? roleName;
  late String? status;

  RoleModel({
    this.roleId,
    this.roleName,
    this.status,
    
  });

  RoleModel.fromJson(Map<String, dynamic> json) {
    roleId = json['role_id'];
    roleName = json['role_name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['role_id'] = roleId;
    data['role_name'] = roleName;
    data['status'] = status;
    return data;
  }
}
