
import 'dart:convert';

OfferModel offerModelFromJson(String str) => OfferModel.fromJson(json.decode(str));

String offerModelToJson(OfferModel data) => json.encode(data.toJson());

class OfferModel {
    final int points;
    final String offer;

    OfferModel({
        required this.points,
        required this.offer,
    });

    factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        points: json["points"],
        offer: json["offer"],
    );

    Map<String, dynamic> toJson() => {
        "points": points,
        "offer": offer,
    };
}
