import 'dart:convert';

import 'package:store_app/models/order_detail.dart';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
    int total;
    List<OrderDetailModel> orders;

    OrderModel({
        required this.total,
        required this.orders,
    });

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        total: json["total"],
        orders: List<OrderDetailModel>.from(json["orders"].map((x) => OrderDetailModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
    };
}


