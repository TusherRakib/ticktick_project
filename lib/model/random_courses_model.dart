// To parse this JSON data, do
//
//     final randomCoursesListModel = randomCoursesListModelFromJson(jsonString);

import 'dart:convert';

RandomCoursesListModel randomCoursesListModelFromJson(String str) => RandomCoursesListModel.fromJson(json.decode(str));

String randomCoursesListModelToJson(RandomCoursesListModel data) => json.encode(data.toJson());

class RandomCoursesListModel {
  bool? status;
  List<Course>? courses;
  String? message;

  RandomCoursesListModel({
    this.status,
    this.courses,
    this.message,
  });

  factory RandomCoursesListModel.fromJson(Map<String, dynamic> json) => RandomCoursesListModel(
        status: json["status"],
        courses: json["courses"] == null ? [] : List<Course>.from(json["courses"]!.map((x) => Course.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "courses": courses == null ? [] : List<dynamic>.from(courses!.map((x) => x.toJson())),
        "message": message,
      };
}

class Course {
  int? id;
  String? title;
  String? description;
  String? videoUrl;
  DateTime? uploadedDate;
  int? categoryId;
  String? image;
  int? featured;
  String? instructorName;
  int? instructorId;
  int? accType;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? status;
  int? enrollmentsCount;

  Course({
    this.id,
    this.title,
    this.description,
    this.videoUrl,
    this.uploadedDate,
    this.categoryId,
    this.image,
    this.featured,
    this.instructorName,
    this.instructorId,
    this.accType,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.enrollmentsCount,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        videoUrl: json["video_url"],
        uploadedDate: json["uploaded_date"] == null ? null : DateTime.parse(json["uploaded_date"]),
        categoryId: json["category_id"],
        image: json["image"],
        featured: json["featured"],
        instructorName: json["instructor_name"],
        instructorId: json["instructor_id"],
        accType: json["acc_type"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        status: json["status"],
        enrollmentsCount: json["enrollments_count"],
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
        "featured": featured,
        "instructor_name": instructorName,
        "instructor_id": instructorId,
        "acc_type": accType,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "status": status,
        "enrollments_count": enrollmentsCount,
      };
}
