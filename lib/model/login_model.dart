// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.success,
    this.message,
    this.data,
    this.errors,
    this.code,
  });

  bool? success;
  String? message;
  Data? data;
  dynamic errors;
  int? code;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    errors: json["errors"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
    "errors": errors,
    "code": code,
  };
}

class Data {
  Data({
    this.user,
    this.token,
  });

  User? user;
  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "token": token,
  };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.status,
    this.fcmToken,
    this.createdBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.avatar,
    this.authenticationProviders
  });

  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? phone;
  int? status;
  String? fcmToken;
  dynamic createdBy;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? avatar;
  List<AuthenticationProvider>? authenticationProviders;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    phone: json["phone"],
    status: json["status"],
    fcmToken: json["fcm_token"],
    createdBy: json["created_by"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    avatar: json["avatar"],
    authenticationProviders: json["authentication_providers"] == null ? [] : List<AuthenticationProvider>.from(json["authentication_providers"]!.map((x) => AuthenticationProvider.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "phone": phone,
    "status": status,
    "fcm_token": fcmToken,
    "created_by": createdBy,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "avatar": avatar,
    "authentication_providers": authenticationProviders == null ? [] : List<dynamic>.from(authenticationProviders!.map((x) => x.toJson())),
  };
}

class AuthenticationProvider {
  int? id;
  String? providerKey;
  String? provider;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  AuthenticationProvider({
    this.id,
    this.providerKey,
    this.provider,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory AuthenticationProvider.fromJson(Map<String, dynamic> json) => AuthenticationProvider(
    id: json["id"],
    providerKey: json["provider_key"],
    provider: json["provider"],
    userId: json["user_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "provider_key": providerKey,
    "provider": provider,
    "user_id": userId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
