// To parse this JSON data, do
//
//     final coursesListModel = coursesListModelFromJson(jsonString);

import 'dart:convert';

CoursesListModel coursesListModelFromJson(String str) => CoursesListModel.fromJson(json.decode(str));

String coursesListModelToJson(CoursesListModel data) => json.encode(data.toJson());

class CoursesListModel {
  bool? status;
  String? message;
  List<Course>? courses;

  CoursesListModel({
    this.status,
    this.message,
    this.courses,
  });

  factory CoursesListModel.fromJson(Map<String, dynamic> json) => CoursesListModel(
        status: json["status"],
        message: json["message"],
        courses: json["courses"] == null ? [] : List<Course>.from(json["courses"]!.map((x) => Course.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "courses": courses == null ? [] : List<dynamic>.from(courses!.map((x) => x.toJson())),
      };
}

class Course {
  int? id;
  String? title;
  String? description;
  dynamic videoUrl;
  DateTime? uploadedDate;
  int? categoryId;
  dynamic image;
  String? instructorName;
  int? instructorId;
  int? accType;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? status;

  Course({
    this.id,
    this.title,
    this.description,
    this.videoUrl,
    this.uploadedDate,
    this.categoryId,
    this.image,
    this.instructorName,
    this.instructorId,
    this.accType,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        videoUrl: json["video_url"],
        uploadedDate: json["uploaded_date"] == null ? null : DateTime.parse(json["uploaded_date"]),
        categoryId: json["category_id"],
        image: json["image"],
        instructorName: json["instructor_name"],
        instructorId: json["instructor_id"],
        accType: json["acc_type"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "video_url": videoUrl,
        "uploaded_date":
            "${uploadedDate!.year.toString().padLeft(4, '0')}-${uploadedDate!.month.toString().padLeft(2, '0')}-${uploadedDate!.day.toString().padLeft(2, '0')}",
        "category_id": categoryId,
        "image": image,
        "instructor_name": instructorName,
        "instructor_id": instructorId,
        "acc_type": accType,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "status": status,
      };
}
