import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class WeCodeUser {
//TODO: from snapshot
  String name;
  String uid;
  String? surName;
  String? imgUrl;
  DateTime createdAt;
  String? github;
  List<String>? skills;
  String? website;
  String? linkedin;
  String email;
  String? phone;
  List<String>? deviceTokens;
  DocumentReference? reference;
  WeCodeUser(
      {required this.name,
      this.surName,
      this.imgUrl,
      required this.createdAt,
      this.github,
      this.skills,
      this.website,
      this.linkedin,
      required this.uid,
      required this.email,
      this.deviceTokens,
      this.phone,
      this.reference});

  WeCodeUser copyWith({
    String? name,
    String? surName,
    String? imgUrl,
    DateTime? createdAt,
    String? github,
    List<String>? skills,
    List<String>? deviceTokens,
    String? website,
    String? linkedin,
    String? email,
    String? uid,
    String? phone,
  }) {
    return WeCodeUser(
      name: name ?? this.name,
      surName: surName ?? this.surName,
      imgUrl: imgUrl ?? this.imgUrl,
      createdAt: createdAt ?? this.createdAt,
      github: github ?? this.github,
      skills: skills ?? this.skills,
      deviceTokens: deviceTokens ?? this.deviceTokens,
      website: website ?? this.website,
      linkedin: linkedin ?? this.linkedin,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surName': surName,
      'imgUrl': imgUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'github': github,
      'skills': skills,
      'website': website,
      'linkedin': linkedin,
      'deviceTokens': deviceTokens,
      'email': email,
      'phone': phone,
      'uid': uid,
    };
  }
  // factory from document snapshot

  factory WeCodeUser.fromSnapShot(DocumentSnapshot documentSnapshot) {
    return WeCodeUser.fromMap(documentSnapshot.data() as Map<String, dynamic>,
        reference: documentSnapshot.reference);
  }

  factory WeCodeUser.fromMap(Map<String, dynamic> map,
      {DocumentReference? reference}) {
    return WeCodeUser(
      name: map['name'] ?? '',
      surName: map['surName'],
      imgUrl: map['imgUrl'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      github: map['github'],
      skills: map['skills'] == null ? null : List<String>.from(map['skills']),
      deviceTokens: map['deviceTokens'] == null
          ? null
          : List<String>.from(map['deviceTokens']),
      website: map['website'],
      linkedin: map['linkedin'],
      email: map['email'] ?? '',
      phone: map['phone'],
      uid: map['uid'],
      reference: reference,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeCodeUser.fromJson(String source) =>
      WeCodeUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WeCodeUser(name: $name, surName: $surName, imgUrl: $imgUrl, createdAt: $createdAt, github: $github, skills: $skills, website: $website, linkedin: $linkedin, email: $email, phone: $phone , deviceTokens: $deviceTokens)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeCodeUser &&
        other.name == name &&
        other.surName == surName &&
        other.imgUrl == imgUrl &&
        other.createdAt == createdAt &&
        other.github == github &&
        listEquals(other.skills, skills) &&
        other.website == website &&
        other.linkedin == linkedin &&
        other.uid == uid &&
        other.email == email &&
        other.phone == phone;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        surName.hashCode ^
        imgUrl.hashCode ^
        createdAt.hashCode ^
        github.hashCode ^
        skills.hashCode ^
        website.hashCode ^
        linkedin.hashCode ^
        uid.hashCode ^
        email.hashCode ^
        phone.hashCode;
  }
}
