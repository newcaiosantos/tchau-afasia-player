import 'package:equatable/equatable.dart';
import 'package:tchauafasiaplayer/model/MediaModel.dart';

class MediaState extends Equatable {
  final bool finding;
  final bool downloading;
  final List<MediaModel> remoteMedia;
  final List<MediaModel> localMedia;

  MediaState({
    this.finding = false,
    this.downloading = false,
    this.remoteMedia = const [],
    this.localMedia = const [],
  });

  @override
  List<Object> get props => [
        finding,
        downloading,
        remoteMedia,
        localMedia,
      ];

  MediaState copyWith({
    bool? finding,
    bool? downloading,
    List<MediaModel>? remoteMedia,
    List<MediaModel>? localMedia,
  }) {
    return MediaState(
      finding: finding ?? this.finding,
      downloading: downloading ?? this.downloading,
      remoteMedia: remoteMedia ?? this.remoteMedia,
      localMedia: localMedia ?? this.localMedia,
    );
  }
}
