// To parse this JSON data, do
//
//     final categoryListModel = categoryListModelFromJson(jsonString);

import 'dart:convert';

CategoryListModel categoryListModelFromJson(String str) => CategoryListModel.fromJson(json.decode(str));

String categoryListModelToJson(CategoryListModel data) => json.encode(data.toJson());

class CategoryListModel {
  bool? status;
  List<Category>? categories;

  CategoryListModel({
    this.status,
    this.categories,
  });

  factory CategoryListModel.fromJson(Map<String, dynamic> json) => CategoryListModel(
        status: json["status"],
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map(
                  (x) => Category.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "categories": categories == null
            ? []
            : List<dynamic>.from(
                categories!.map(
                  (x) => x.toJson(),
                ),
              ),
      };
}

class Category {
  int? id;
  String? name;
  String? thumbnail;
  int? parentId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Category>? subCat;

  Category({
    this.id,
    this.name,
    this.thumbnail,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.subCat,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        thumbnail: json["thumbnail"],
        parentId: json["parent_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        subCat: json["subCat"] == null
            ? []
            : List<Category>.from(
                json["subCat"]!.map(
                  (x) => Category.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "thumbnail": thumbnail,
        "parent_id": parentId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "subCat": subCat == null
            ? []
            : List<dynamic>.from(
                subCat!.map(
                  (x) => x.toJson(),
                ),
              ),
      };
}
