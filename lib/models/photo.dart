import 'package:flutter/material.dart';

class Photo {
  final String? id;
  final String? name;
  final String? surname;
  final String? url;
  final String? thumbnailUrl;
  final int? likes;
  final bool? liked;

  Photo(
      {this.id,
      this.name,
      this.surname,
      this.url,
      this.thumbnailUrl,
      this.likes,
      this.liked});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] ?? UniqueKey().toString(),
      name: json['user']['first_name'],
      surname: json['user']['last_name'],
      url: json['urls']['full'],
      thumbnailUrl: json['urls']['thumb'],
      likes: json['likes'] ?? 0,
      liked: json['liked_by_user'] ?? false,
    );
  }
}
