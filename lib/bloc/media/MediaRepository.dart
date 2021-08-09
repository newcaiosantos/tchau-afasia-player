import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tchauafasiaplayer/model/MediaModel.dart';
import 'package:tchauafasiaplayer/model/MediaModelPage.dart';

class MediaRepository {
  static const String boxId = "mediaBox";

  Future<MediaModelPage> findMedia() async {
    print("[MediaRepository][findMedia] ");
    final url = "https://tchau-afasia-core.herokuapp.com/media";
    final res = await Dio().get(url, queryParameters: {
      "page": 0,
      "size": 100,
      "sortBy": "createdAt",
      "asc": "false"
    });
    final resData = res.data;
    final page = MediaModelPage.fromMap(resData);
    print("[MediaRepository][findMedia] done");
    return page;
  }

  downloadMedia(MediaModel media) async {
    await _downloadThumbnail(media);
    await _downloadVideo(media);
    await _saveLocalMedia(media);
  }

  Box get _box {
    return Hive.box(boxId);
  }

  _saveLocalMedia(MediaModel media) async {
    await _box.put(media.id, media);
  }

  _downloadVideo(MediaModel media) async {
    final url = media.videoUrl;
    if (url == null || url.isEmpty) throw Exception("missing video url");
    final filename = "${media.id}.mp4";
    final dir = await getApplicationDocumentsDirectory();
    return await Dio().download(url, "${dir.path}/$filename");
  }

  _downloadThumbnail(MediaModel media) async {
    final url = media.thumbnailUrl;
    if (url == null || url.isEmpty) throw Exception("missing thumbnail url");
    final filename = "${media.id}.jpg";
    final dir = await getApplicationDocumentsDirectory();
    return await Dio().download(url, "${dir.path}/$filename");
  }
}
