// user_id, user_name, email, password, birthday, avatar, address, phone, accessChangePassword, refresh_token, role_id, status

import 'package:matching/model/role_model.dart';

// List<UserModel> usersFromJson(dynamic str) =>
// List<UserModel>.from((str).map((x) => UserModel.fromJson(x)));

List<UserModel> usersFromJson(dynamic str) {

  final rows = str['rows'];

  return List<UserModel>.from(rows.map((x) => UserModel.fromJson(x)));
}


class UserModel {
  late String? id;
  late String? name;
  late String? email;
  late String? password;
  late DateTime? yob;
  late String? avatar;
  late String? address;
  late String? phone;
  late String? accessChangePassword;
  late String? refreshToken;
  late RoleModel? roleModel;
  late String? status;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.yob,
    this.avatar,
    this.address,
    this.phone,
    this.accessChangePassword,
    this.refreshToken,
    this.roleModel,
    this.status,
    
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['user_id'];
    name = json['user_name'];
    email = json['email'];
    password = json['password'];
    yob = json['birthday'];
    avatar = json['avatar'];
    address = json['address'];
    phone = json['phone'];
    accessChangePassword = json['accessChangePassword'];
    refreshToken = json['refresh_token'];
    roleModel = json['role_model'] != null
      ? RoleModel.fromJson(json['role_model'])
      : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
<<<<<<< HEAD
    data['_id'] = id;
=======
    data['user_id'] = id;
>>>>>>> phuc
    data['user_name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['birthday'] = yob;
    data['avatar'] = avatar;
    data['address'] = address;
    data['phone'] = phone;
    data['accessChangePassword'] = accessChangePassword;
    data['refresh_token'] = refreshToken;
<<<<<<< HEAD
    data['role_id'] = roleId;
=======
    if (roleModel != null) {
      data['role_model'] = roleModel!.toJson();
    }
>>>>>>> phuc
    data['status'] = status;
    return data;
  }
}
