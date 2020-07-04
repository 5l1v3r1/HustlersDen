import 'package:flutter/foundation.dart';

class Note {
  final int id;
  final String title;
  final String contents;
  Note({
    @required this.id,
    this.title,
    @required this.contents,
  });
  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["id"],
        title: json["title"],
        contents: json["contents"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "contents": contents,
      };
  @override
  String toString() {
    return '$id : $title, $contents';
  }
}
