import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'MediaModel.g.dart';

// How to generate adapter: flutter packages pub run build_runner build
@HiveType(typeId: 0)
class MediaModel extends Equatable {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? createdAt;

  @HiveField(2)
  final String? title;

  @HiveField(3)
  final String? thumbnail;

  @HiveField(4)
  final String? thumbnailUrl;

  @HiveField(5)
  final String? video;

  @HiveField(6)
  final String? videoUrl;

  MediaModel({
    this.id,
    this.createdAt,
    this.title,
    this.thumbnail,
    this.thumbnailUrl,
    this.video,
    this.videoUrl,
  });

  @override
  List<Object?> get props {
    return [
      id,
      createdAt,
      title,
      thumbnail,
      thumbnailUrl,
      video,
      videoUrl,
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt,
      'title': title,
      'thumbnail': thumbnail,
      'thumbnailUrl': thumbnailUrl,
      'video': video,
      'videoUrl': videoUrl,
    };
  }

  factory MediaModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return MediaModel();

    return MediaModel(
      id: map['id'],
      createdAt: map['createdAt'],
      title: map['title'],
      thumbnail: map['thumbnail'],
      thumbnailUrl: map['thumbnailUrl'],
      video: map['video'],
      videoUrl: map['videoUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MediaModel.fromJson(String source) =>
      MediaModel.fromMap(json.decode(source));

  MediaModel copyWith({
    int? id,
    String? createdAt,
    String? title,
    String? thumbnail,
    String? thumbnailUrl,
    String? video,
    String? videoUrl,
  }) {
    return MediaModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      video: video ?? this.video,
      videoUrl: videoUrl ?? this.videoUrl,
    );
  }
}
