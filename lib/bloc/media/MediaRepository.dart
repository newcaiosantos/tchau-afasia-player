import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:tchauafasiaplayer/config/BootConfig.dart';
import 'package:tchauafasiaplayer/model/MediaModel.dart';
import 'package:tchauafasiaplayer/model/MediaModelPage.dart';
import 'package:tchauafasiaplayer/tool/MediaTool.dart';

class MediaRepository {
  late Box<MediaModel> box;

  MediaRepository({
    required this.box,
  });

  static const String boxId = "mediaBox";

  Future<MediaModelPage> findRemoteMedia() async {
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
  }

  List<MediaModel> findLocalMedia() {
    final List<MediaModel> localMedia = [];
    box.keys.map((it) => box.get(it)).where((it) => it != null).forEach((it) {
      localMedia.add(it!);
    });
    return localMedia;
  }

  Future<void> putLocalMedia(MediaModel media) async {
    await box.put(media.id, media);
  }

  Future<void> deleteLocalMedia(MediaModel media) async {
    await box.delete(media.id);
  }

  _downloadVideo(MediaModel media) async {
    final url = media.videoUrl;
    if (url == null || url.isEmpty) throw Exception("missing video url");
    return await Dio().download(url, MediaTool.videoPathOf(media));
  }

  _downloadThumbnail(MediaModel media) async {
    final url = media.thumbnailUrl;
    if (url == null || url.isEmpty) throw Exception("missing thumbnail url");
    return await Dio().download(url, MediaTool.thumbnailPathOf(media));
  }

  deleteMediaFiles(MediaModel media) async {
    final thumb = File(MediaTool.thumbnailPathOf(media));
    final video = File(MediaTool.videoPathOf(media));
    if (await thumb.exists()) await thumb.delete();
    if (await video.exists()) await video.delete();
  }

  Future<List<String>> mediaFilePaths() async {
    final filePaths = BootConfig.mediaDir.list().map((it) => it.path);
    return filePaths
        .where((it) => it.endsWith(".mp4") || it.endsWith(".jpg"))
        .toList();
  }
}
