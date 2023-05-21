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
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['user_name'] = name;
    _data['email'] = email;
    _data['password'] = password;
    _data['birthday'] = yob;
    _data['avatar'] = avatar;
    _data['address'] = address;
    _data['phone'] = phone;
    _data['accessChangePassword'] = accessChangePassword;
    _data['refresh_token'] = refreshToken;
    _data['role_id'] = roleId;
    _data['status'] = status;
    return _data;
  }
}
