import 'dart:convert';

class AddTaskResponseModel {
    final String title;
    final String description;

    AddTaskResponseModel({
        required this.title,
        required this.description,
    });

    factory AddTaskResponseModel.fromRawJson(String str) => AddTaskResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AddTaskResponseModel.fromJson(Map<String, dynamic> json) => AddTaskResponseModel(
        title: json["title"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
    };
}
