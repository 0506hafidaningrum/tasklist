import 'dart:convert';

class TaskResponseModel {
  final List<Task> data;

  TaskResponseModel({
    required this.data,
  });

  factory TaskResponseModel.fromRawJson(String str) => TaskResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaskResponseModel.fromJson(Map<String, dynamic> json) => TaskResponseModel(
    data: List<Task>.from(json["data"].map((x) => Task.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Task {
  final String id;
  final Attributes attributes;

  Task({
    required this.id,
    required this.attributes,
  });

  factory Task.fromRawJson(String str) => Task.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json["id"],
    attributes: Attributes.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "attributes": attributes.toJson(),
  };
}

class Attributes {
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Attributes({
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Attributes.fromRawJson(String str) => Attributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    title: json["title"],
    description: json["description"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
