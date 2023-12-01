// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    final String? userId;
    final String? userName;
    final String? userEmail;
    final String? userGender;
    final String? userAddress;
    final int? earnedPoints;
    final String? offer;
    final String? role;
    final bool? isEmailVerified;

    UserModel({
        this.userId,
        this.userName,
        this.userEmail,
        this.userGender,
        this.userAddress,
        this.earnedPoints,
        this.offer,
        this.role,
        this.isEmailVerified,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["userId"],
        userName: json["userName"],
        userEmail: json["userEmail"],
        userGender: json["userGender"],
        userAddress: json["userAddress"],
        earnedPoints: json["earnedPoints"],
        offer: json["offer"],
        role: json["role"],
        isEmailVerified: json["isEmailVerified"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
        "userEmail": userEmail,
        "userGender": userGender,
        "userAddress": userAddress,
        "earnedPoints": earnedPoints,
        "offer": offer,
        "role": role,
        "isEmailVerified": isEmailVerified,
    };
}
