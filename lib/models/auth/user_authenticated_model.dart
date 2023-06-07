import 'dart:convert';

UserAuthenticatedModel userAuthenticatedModelFromJson(String str) =>
    UserAuthenticatedModel.fromJson(json.decode(str));

String userAuthenticatedModelToJson(UserAuthenticatedModel data) =>
    json.encode(data.toJson());

class UserAuthenticatedModel {
  UserAuthenticatedModel({
    this.id,
    this.login,
    this.firstname,
    this.lastname,
    this.email,
    this.token,
  });

  final int? id;
  final String? login;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? token;

  factory UserAuthenticatedModel.fromJson(Map<String, dynamic> json) =>
      UserAuthenticatedModel(
        id: json["id"],
        login: json["login"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "login": login,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "token": token,
      };
}
