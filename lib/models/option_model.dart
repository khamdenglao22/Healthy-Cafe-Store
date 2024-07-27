class OptionModel {
  int id;
  int optionId;
  String optionName;
  double optionPrice;

  OptionModel({
    required this.id,
    required this.optionId,
    required this.optionName,
    required this.optionPrice,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) => OptionModel(
        id: json["id"],
        optionId: json["optionId"],
        optionName: json["optionName"],
        optionPrice: json["optionPrice"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "optionId": optionId,
        "optionName": optionName,
        "optionPrice": optionPrice,
      };
}
