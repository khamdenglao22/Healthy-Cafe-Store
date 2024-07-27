import 'package:store_app/models/option_model.dart';

class OrderItemModel {
  int id;
  int qty;
  double price;
  double discount;
  double subtotal;
  double actualSale;
  int productId;
  String productName;
  String productImage;
  String unitName;
  String? remark;
  List<OptionModel>? options;

  OrderItemModel({
    required this.id,
    required this.qty,
    required this.price,
    required this.discount,
    required this.subtotal,
    required this.actualSale,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.unitName,
    required this.remark,
    this.options,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
        id: json["id"],
        qty: json["qty"],
        price: json["price"],
        discount: json["discount"],
        subtotal: json["subtotal"],
        actualSale: json["actualSale"],
        productId: json["productId"],
        productName: json["productName"],
        productImage: json["productImage"],
        unitName: json["unitName"],
        remark: json["remark"],
        options: json["options"] == null
            ? []
            : List<OptionModel>.from(
                json["options"]!.map((x) => OptionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "qty": qty,
        "price": price,
        "discount": discount,
        "subtotal": subtotal,
        "actualSale": actualSale,
        "productId": productId,
        "productName": productName,
        "productImage": productImage,
        "unitName": unitName,
        "remark": remark,
        "options": options == null
            ? []
            : List<dynamic>.from(options!.map((x) => x.toJson())),
      };
}
