class LoginResponseModel {
  LoginResponseModel({
    this.data,
    this.message,
    this.status,
  });

  LoginResponseModel.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }
  Data? data;
  String? message;
  num? status;
  LoginResponseModel copyWith({
    Data? data,
    String? message,
    num? status,
  }) =>
      LoginResponseModel(
        data: data ?? this.data,
        message: message ?? this.message,
        status: status ?? this.status,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['message'] = message;
    map['status'] = status;
    return map;
  }
}

class Data {
  Data({
    this.token,
    this.user,
  });

  Data.fromJson(dynamic json) {
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? token;
  User? user;
  Data copyWith({
    String? token,
    User? user,
  }) =>
      Data(
        token: token ?? this.token,
        user: user ?? this.user,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}

class User {
  User({
    this.id,
    this.name,
    this.slug,
    this.picture,
    this.email,
    this.phone,
    this.emailVerifiedAt,
    this.balance,
    this.type,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    picture = json['picture'];
    email = json['email'];
    phone = json['phone'];
    emailVerifiedAt = json['email_verified_at'];
    balance = json['balance'];
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? name;
  String? slug;
  dynamic picture;
  String? email;
  String? phone;
  dynamic emailVerifiedAt;
  dynamic balance;
  String? type;
  String? status;
  String? createdAt;
  String? updatedAt;
  User copyWith({
    num? id,
    String? name,
    String? slug,
    dynamic picture,
    String? email,
    String? phone,
    dynamic emailVerifiedAt,
    dynamic balance,
    String? type,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        picture: picture ?? this.picture,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        balance: balance ?? this.balance,
        type: type ?? this.type,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['picture'] = picture;
    map['email'] = email;
    map['phone'] = phone;
    map['email_verified_at'] = emailVerifiedAt;
    map['balance'] = balance;
    map['type'] = type;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
