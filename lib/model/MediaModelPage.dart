import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:tchauafasiaplayer/model/MediaModel.dart';

class MediaModelPage extends Equatable {
  final List<MediaModel>? content;
  final int? totalPages;

  MediaModelPage({
    this.content,
    this.totalPages,
  });

  @override
  List<Object?> get props {
    return [
      content,
      totalPages,
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'totalPages': totalPages,
    };
  }

  factory MediaModelPage.fromMap(Map<String, dynamic>? map) {
    if (map == null) return MediaModelPage();

    return MediaModelPage(
      content: List<MediaModel>.from(
          map['content']?.map((it) => MediaModel?.fromMap(it))),
      totalPages: map['totalPages'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MediaModelPage.fromJson(String source) =>
      MediaModelPage.fromMap(json.decode(source));
}
