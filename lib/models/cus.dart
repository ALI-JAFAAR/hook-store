// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

// ignore_for_file: prefer_null_aware_operators, prefer_if_null_operators

import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
    Customer({
        required this.success,
        required this.data,
    });

    bool success;
    Data data;

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        success: json["success"],
        data:  Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data":data.toJson(),
    };
}

class Data {
    Data({
        required this.name,
        required this.phone,
        required this.id,
    });

    String? name;
    String? phone;
    int? id;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        phone:json["phone"],
        id:json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "id":id,
    };
}