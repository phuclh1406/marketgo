// user_id, user_name, email, password, birthday, avatar, address, phone, accessChangePassword, refresh_token, role_id, status

List<UserModel> usersFromJson(dynamic str) =>
    List<UserModel>.from((str).map((x) => UserModel.fromJson(x)));

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
  late String? roleId;
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
    this.roleId,
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
    roleId = json['role_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['user_name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['birthday'] = yob;
    data['avatar'] = avatar;
    data['address'] = address;
    data['phone'] = phone;
    data['accessChangePassword'] = accessChangePassword;
    data['refresh_token'] = refreshToken;
    data['role_id'] = roleId;
    data['status'] = status;
    return data;
  }
}
