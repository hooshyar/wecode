import 'dart:convert';

import 'package:wecode/src/models/weCodeUser_data_model.dart';

// the
class Vacancy {
  String type;
  String id; //remote, intern, part-time, full-time
  String title;
  String description; //create a text editor for mark down
  String? responsibilities;
  String org;
  String city;
  String category; //flutter, ds,
  int? upVote;
  int? downVote;
  String? dynamicLink;
  DateTime? expDate;
  DateTime createdAt;
  WeCodeUser user;
  Vacancy({
    required this.type,
    required this.title,
    required this.id,
    required this.description,
    this.responsibilities,
    required this.org,
    required this.city,
    required this.category,
    this.upVote,
    this.downVote,
    this.dynamicLink,
    this.expDate,
    required this.createdAt,
    required this.user,
  });

  Vacancy copyWith({
    String? type,
    String? id,
    String? title,
    String? description,
    String? responsibilities,
    String? org,
    String? city,
    String? category,
    int? upVote,
    int? downVote,
    String? dynamicLink,
    DateTime? expDate,
    DateTime? createdAt,
    WeCodeUser? user,
  }) {
    return Vacancy(
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      responsibilities: responsibilities ?? this.responsibilities,
      org: org ?? this.org,
      city: city ?? this.city,
      id: id ?? this.id,
      category: category ?? this.category,
      upVote: upVote ?? this.upVote,
      downVote: downVote ?? this.downVote,
      dynamicLink: dynamicLink ?? this.dynamicLink,
      expDate: expDate ?? this.expDate,
      createdAt: createdAt ?? this.createdAt,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'title': title,
      'description': description,
      'responsibilities': responsibilities,
      'org': org,
      'city': city,
      'id': id,
      'category': category,
      'upVote': upVote,
      'downVote': downVote,
      'dynamicLink': dynamicLink,
      'expDate': expDate?.millisecondsSinceEpoch,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'user': user.toMap(),
    };
  }

  factory Vacancy.fromMap(Map<String, dynamic> map) {
    return Vacancy(
      type: map['type'] ?? '',
      title: map['title'] ?? '',
      id: map['id'] ?? 'no id',
      description: map['description'] ?? '',
      responsibilities: map['responsibilities'],
      org: map['org'] ?? '',
      city: map['city'] ?? '',
      category: map['category'] ?? '',
      upVote: map['upVote']?.toInt(),
      downVote: map['downVote']?.toInt(),
      dynamicLink: map['dynamicLink'],
      expDate: map['expDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['expDate'])
          : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      user: WeCodeUser.fromMap(map['user'].cast<String, dynamic>()),
    );
  }

  String toJson() => json.encode(toMap());

  factory Vacancy.fromJson(String source) =>
      Vacancy.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Vacancy(type: $type, title: $title, description: $description, responsibilities: $responsibilities, org: $org, city: $city, category: $category, upVote: $upVote, downVote: $downVote, dynamicLink: $dynamicLink, expDate: $expDate, createdAt: $createdAt, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Vacancy &&
        other.type == type &&
        other.title == title &&
        other.description == description &&
        other.responsibilities == responsibilities &&
        other.org == org &&
        other.city == city &&
        other.category == category &&
        other.upVote == upVote &&
        other.downVote == downVote &&
        other.dynamicLink == dynamicLink &&
        other.expDate == expDate &&
        other.createdAt == createdAt &&
        other.user == user;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        title.hashCode ^
        description.hashCode ^
        responsibilities.hashCode ^
        org.hashCode ^
        city.hashCode ^
        category.hashCode ^
        upVote.hashCode ^
        downVote.hashCode ^
        dynamicLink.hashCode ^
        expDate.hashCode ^
        createdAt.hashCode ^
        user.hashCode;
  }
}
