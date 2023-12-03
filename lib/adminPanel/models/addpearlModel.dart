// To parse this JSON data, do
//
//     final uploadPearlModel = uploadPearlModelFromJson(jsonString);

import 'dart:convert';

UploadPearlModel uploadPearlModelFromJson(String str) => UploadPearlModel.fromJson(json.decode(str));

String uploadPearlModelToJson(UploadPearlModel data) => json.encode(data.toJson());

class UploadPearlModel {
    final String? pearlImage;
    final String? pearlName;
    final String? pearlDescription;
    final int? pearlPrice;
    final int? stock;

    UploadPearlModel({
        this.pearlImage,
        this.pearlName,
        this.pearlDescription,
        this.pearlPrice,
        this.stock,
    });

    factory UploadPearlModel.fromJson(Map<String, dynamic> json) => UploadPearlModel(
        pearlImage: json["pearlImage"],
        pearlName: json["pearlName"],
        pearlDescription: json["pearlDescription"],
        pearlPrice: json["pearlPrice"],
        stock: json["stock"],
    );

    Map<String, dynamic> toJson() => {
        "pearlImage": pearlImage,
        "pearlName": pearlName,
        "pearlDescription": pearlDescription,
        "pearlPrice": pearlPrice,
        "stock": stock,
    };
}
