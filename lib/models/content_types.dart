// To parse this JSON data, do
//
//     final contentType = contentTypeFromJson(jsonString);

import 'dart:convert';

List<ContentType> contentTypeFromJson(String str) => List<ContentType>.from(
    json.decode(str).map((x) => ContentType.fromJson(x)));

String contentTypeToJson(List<ContentType> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ContentType {
  ContentType({
    required this.typeNum,
    required this.typeName,
    required this.owner,
    required this.note,
  });

  int typeNum;
  String typeName;
  String owner;
  String note;

  factory ContentType.fromJson(Map<String, dynamic> json) => ContentType(
        typeNum: json["num"],
        typeName: json["type_name"],
        owner: json["owner"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "num": typeNum,
        "type_name": typeName,
        "owner": owner,
        "note": note,
      };
}
