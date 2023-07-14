// To parse this JSON data, do
//
//     final cat = catFromJson(jsonString);

import 'dart:convert';

Cat catFromJson(String str) => Cat.fromJson(json.decode(str));

String catToJson(Cat data) => json.encode(data.toJson());

class Cat {
    Cat({
        required this.success,
        required this.data,
    });

    bool success;
    List<Datum> data;

    factory Cat.fromJson(Map<String, dynamic> json) => Cat(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        required this.id,
        required this.name,
        required this.img,
        required this.place,
        required this.priority,
        required this.createdAt,
        required this.updatedAt,
        required this.shops,
    });

    int id;
    String name;
    String img;
    int place;
    int priority;
    DateTime createdAt;
    DateTime updatedAt;
    List<Shop> shops;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        img: json["img"],
        place: json["place"],
        priority: json["priority"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        shops: List<Shop>.from(json["shops"].map((x) => Shop.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "img": img,
        "place": place,
        "priority": priority,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "shops": List<dynamic>.from(shops.map((x) => x.toJson())),
    };
}

class Shop {
    Shop({
        required this.id,
        required this.name,
        required this.img,
        required this.phone,
        required this.address,
        required this.discount,
        required this.details,
        required this.facebook,
        required this.instgram,
        required this.catsId,
        required this.priority,
        required this.createdAt,
        required this.updatedAt,
        required this.offer,
    });

    int id;
    String name;
    String img;
    String phone;
    String address;
    String discount,facebook,instgram;
    String details;
    int catsId;
    int priority;
    DateTime createdAt;
    DateTime updatedAt;
    List<Offer> offer;

    factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["id"],
        name: json["name"],
        img: json["img"],
        phone: json["phone"],
        address: json["address"],
        discount: json["discount"],
        facebook: json["facebook"],
        instgram: json["instgram"],
        details: json["details"],
        catsId: json["cats_id"],
        priority: json["priority"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        offer: List<Offer>.from(json["offer"].map((x) => Offer.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "img": img,
        "phone": phone,
        "address": address,
        "discount": discount,
        "facebook": facebook,
        "insgram": instgram,
        "details": details,
        "cats_id": catsId,
        "priority": priority,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "offer": List<dynamic>.from(offer.map((x) => x.toJson())),
    };
}

class Offer {
    Offer({
        required this.id,
        required this.shopId,
        required this.img,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    int shopId;
    String img;
    DateTime createdAt;
    DateTime updatedAt;

    factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        shopId: json["shop_id"],
        img: json["img"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "shop_id": shopId,
        "img": img,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}