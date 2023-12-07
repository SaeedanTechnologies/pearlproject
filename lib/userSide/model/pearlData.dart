// To parse this JSON data, do
//
//     final pearlData = pearlDataFromJson(jsonString);

import 'dart:convert';

PearlData pearlDataFromJson(String str) => PearlData.fromJson(json.decode(str));

String pearlDataToJson(PearlData data) => json.encode(data.toJson());

class PearlData {
    final String? pearlImage;
    final String? documentId;

    PearlData({
        this.pearlImage,
        this.documentId,
    });

    factory PearlData.fromJson(Map<String, dynamic> json) => PearlData(
        pearlImage: json["pearlImage"],
        documentId: json["documentId"],
    );

    Map<String, dynamic> toJson() => {
        "pearlImage": pearlImage,
        "documentId": documentId,
    };
}
