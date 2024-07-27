import 'dart:convert';

List<RiderModel> riderModelFromJson(String str) => List<RiderModel>.from(json.decode(str).map((x) => RiderModel.fromJson(x)));

String riderModelToJson(List<RiderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RiderModel {
    int id;
    String name;
    String phoneNo;

    RiderModel({
        required this.id,
        required this.name,
        required this.phoneNo,
    });

    factory RiderModel.fromJson(Map<String, dynamic> json) => RiderModel(
        id: json["id"],
        name: json["name"],
        phoneNo: json["phoneNo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phoneNo": phoneNo,
    };
}
