import 'dart:convert';

class Vacancy {
  String type; //remote, intern, part-time, full-time
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
  Vacancy({
    required this.type,
    required this.title,
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
  });

  Vacancy copyWith({
    String? type,
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
  }) {
    return Vacancy(
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      responsibilities: responsibilities ?? this.responsibilities,
      org: org ?? this.org,
      city: city ?? this.city,
      category: category ?? this.category,
      upVote: upVote ?? this.upVote,
      downVote: downVote ?? this.downVote,
      dynamicLink: dynamicLink ?? this.dynamicLink,
      expDate: expDate ?? this.expDate,
      createdAt: createdAt ?? this.createdAt,
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
      'category': category,
      'upVote': upVote,
      'downVote': downVote,
      'dynamicLink': dynamicLink,
      'expDate': expDate?.millisecondsSinceEpoch,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Vacancy.fromMap(Map<String, dynamic> map) {
    return Vacancy(
      type: map['type'] ?? '',
      title: map['title'] ?? '',
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
    );
  }

  String toJson() => json.encode(toMap());

  factory Vacancy.fromJson(String source) =>
      Vacancy.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Vacancy(type: $type, title: $title, description: $description, responsibilities: $responsibilities, org: $org, city: $city, category: $category, upVote: $upVote, downVote: $downVote, : $dynamicLink, expDate: $expDate, createdAt: $createdAt)';
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
        other.createdAt == createdAt;
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
        createdAt.hashCode;
  }
}
