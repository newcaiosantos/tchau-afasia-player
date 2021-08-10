import 'package:tchauafasiaplayer/model/MediaModel.dart';

class InconsistentMediaModel {
  final List<String> paths;
  final List<MediaModel> media;

  InconsistentMediaModel({
    required this.paths,
    required this.media,
  });
}
