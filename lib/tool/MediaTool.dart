import 'package:tchauafasiaplayer/config/BootConfig.dart';
import 'package:tchauafasiaplayer/model/MediaModel.dart';

class MediaTool {
  static String thumbnailPathOf(MediaModel media) {
    final mediaPath = BootConfig.mediaDir.path;
    return "$mediaPath/${media.id}.jpg";
  }

  static String videoPathOf(MediaModel media) {
    final mediaPath = BootConfig.mediaDir.path;
    return "$mediaPath/${media.id}.mp4";
  }
}
