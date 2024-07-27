import 'dart:convert';

import 'package:store_app/models/order_item.dart';

OrderDetailModel orderDetailModelFromJson(String str) =>
    OrderDetailModel.fromJson(json.decode(str));

String orderDetailModelToJson(OrderDetailModel data) =>
    json.encode(data.toJson());

List<OrderDetailModel> orderDetailModelListFromJson(String str) =>
    List<OrderDetailModel>.from(
        json.decode(str).map((x) => OrderDetailModel.fromJson(x)));

String orderDetailModelListToJson(List<OrderDetailModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderDetailModel {
  String orderId;
  DateTime orderDate;
  double subtotal;
  double discountAmount;
  double taxAmount;
  double actualSale;
  double deliveryCost;
  String? paymentRef;
  String? deliverySuccessDate;
  String? reasonForCancel;
  String? reasonForDeliveryFail;
  int customerId;
  String customerName;
  String customerPhone;
  int deliveryId;
  String deliveryDetail;
  String deliveryPhone;
  String deliveryLongitude;
  String deliveryLatitude;
  int paymentMethodId;
  String paymentMethodName;
  int paymentStatusId;
  String paymentStatusName;
  int orderStatusId;
  String orderStatusName;
  int riderId;
  String? riderFullname;
  String? riderPhone;
  String? remark;
  List<OrderItemModel> orderItems;

  OrderDetailModel({
    required this.orderId,
    required this.orderDate,
    required this.subtotal,
    required this.discountAmount,
    required this.taxAmount,
    required this.actualSale,
    required this.deliveryCost,
    this.paymentRef,
    this.deliverySuccessDate,
    this.reasonForCancel,
    this.reasonForDeliveryFail,
    required this.customerId,
    required this.customerName,
    required this.customerPhone,
    required this.deliveryId,
    required this.deliveryDetail,
    required this.deliveryPhone,
    required this.deliveryLongitude,
    required this.deliveryLatitude,
    required this.paymentMethodId,
    required this.paymentMethodName,
    required this.paymentStatusId,
    required this.paymentStatusName,
    required this.orderStatusId,
    required this.orderStatusName,
    required this.riderId,
    this.riderFullname,
    this.riderPhone,
    this.remark,
    required this.orderItems,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailModel(
        orderId: json["orderId"],
        orderDate: DateTime.parse(json["orderDate"]),
        subtotal: json["subtotal"],
        discountAmount: json["discountAmount"],
        taxAmount: json["taxAmount"],
        actualSale: json["actualSale"],
        deliveryCost: json["deliveryCost"],
        paymentRef: json["paymentRef"],
        deliverySuccessDate: json["deliverySuccessDate"],
        reasonForCancel: json["reasonForCancel"],
        reasonForDeliveryFail: json["reasonForDeliveryFail"],
        customerId: json["customerId"],
        customerName: json["customerName"] == null ? '' : json["customerName"],
        customerPhone: json["customerPhone"],
        deliveryId: json["deliveryId"],
        deliveryDetail: json["deliveryDetail"],
        deliveryPhone: json["deliveryPhone"],
        deliveryLongitude: json["deliveryLongitude"],
        deliveryLatitude: json["deliveryLatitude"],
        paymentMethodId: json["paymentMethodId"],
        paymentMethodName: json["paymentMethodName"],
        paymentStatusId: json["paymentStatusId"],
        paymentStatusName: json["paymentStatusName"],
        orderStatusId: json["orderStatusId"],
        orderStatusName: json["orderStatusName"],
        riderId: json["riderId"],
        riderFullname: json["riderFullname"],
        riderPhone: json["riderPhone"],
        remark: json["remark"],
        orderItems: List<OrderItemModel>.from(
            json["orderItems"].map((x) => OrderItemModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "orderDate": orderDate.toIso8601String(),
        "subtotal": subtotal,
        "discountAmount": discountAmount,
        "taxAmount": taxAmount,
        "actualSale": actualSale,
        "deliveryCost": deliveryCost,
        "paymentRef": paymentRef,
        "deliverySuccessDate": deliverySuccessDate,
        "reasonForCancel": reasonForCancel,
        "reasonForDeliveryFail": reasonForDeliveryFail,
        "customerId": customerId,
        "customerName": customerName,
        "customerPhone": customerPhone,
        "deliveryId": deliveryId,
        "deliveryDetail": deliveryDetail,
        "deliveryPhone": deliveryPhone,
        "deliveryLongitude": deliveryLongitude,
        "deliveryLatitude": deliveryLatitude,
        "paymentMethodId": paymentMethodId,
        "paymentMethodName": paymentMethodName,
        "paymentStatusId": paymentStatusId,
        "paymentStatusName": paymentStatusName,
        "orderStatusId": orderStatusId,
        "orderStatusName": orderStatusName,
        "riderId": riderId,
        "riderFullname": riderFullname,
        "riderPhone": riderPhone,
        "remark": remark,
        "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
      };
}
