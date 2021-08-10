import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tchauafasiaplayer/bloc/media/MediaRepository.dart';
import 'package:tchauafasiaplayer/bloc/media/MediaState.dart';
import 'package:tchauafasiaplayer/model/Inconsistent.dart';
import 'package:tchauafasiaplayer/model/MediaModel.dart';
import 'package:tchauafasiaplayer/tool/MediaTool.dart';

class MediaBloc extends Cubit<MediaState> {
  late final MediaRepository _mediaRepository;

  MediaBloc(BuildContext context) : super(MediaState()) {
    _mediaRepository = context.read<MediaRepository>();
    _init();
  }

  _init() {
    _loadLocalMedia();
  }

  _loadLocalMedia() {
    final localMedia = _mediaRepository.findLocalMedia();
    emit(state.copyWith(localMedia: localMedia));
  }

  findRemoteMedia() async {
    print("[MediaBloc][findRemoteMedia]");
    emit(state.copyWith(finding: true));
    try {
      final media = await _mediaRepository.findRemoteMedia();
      emit(state.copyWith(
        remoteMedia: media.content,
        finding: false,
      ));
      print("[MediaBloc][findRemoteMedia] done");
    } catch (e) {
      print("[MediaBloc][findRemoteMedia] e: $e");
      emit(state.copyWith(finding: false));
      throw e;
    }
  }

  deleteLocalMedia(MediaModel media) async {
    print("[MediaBloc][deleteLocalMedia]");
    try {
      await _mediaRepository.deleteMediaFiles(media);
      await _mediaRepository.deleteLocalMedia(media);
      emit(state.copyWith(
          localMedia:
              state.localMedia.where((it) => it.id != media.id).toList()));
      print("[MediaBloc][deleteLocalMedia] done");
    } catch (e) {
      print("[MediaBloc][deleteLocalMedia] e: $e");
      throw e;
    }
  }

  downloadMedia(MediaModel media) async {
    print("[MediaBloc][downloadMedia]");
    final contains = state.localMedia.any((it) => it.id == media.id);
    if (contains) throw Exception("already contains local media");
    emit(state.copyWith(downloading: true));
    try {
      await _mediaRepository.downloadMedia(media);
      await _mediaRepository.putLocalMedia(media);
      emit(state.copyWith(
        localMedia: [media] + state.localMedia,
        downloading: false,
      ));
      print("[MediaBloc][downloadMedia] done");
    } catch (e) {
      print("[MediaBloc][downloadMedia] e: $e");
      emit(state.copyWith(downloading: false));
      throw e;
    }
  }

  deleteInconsistent() async {
    final inconsistent = await _inconsistent();
    print(
        "[MediaBloc][deleteInconsistent] inconsistent paths: ${inconsistent.paths.length}");
    print(
        "[MediaBloc][deleteInconsistent] inconsistent local media: ${inconsistent.media.length}");
    inconsistent.paths.forEach((it) {
      final file = File(it);
      file.exists().then((yes) {
        if (yes) file.delete();
      });
    });
    emit(state.copyWith(
        localMedia: state.localMedia
            .where((it) => !inconsistent.media.map((m) => m.id).contains(it.id))
            .toList()));
    print("[MediaBloc][deleteInconsistent] done");
  }

  Future<InconsistentMediaModel> _inconsistent() async {
    final media = state.localMedia;
    print("[MediaBloc][_inconsistent] local media: ${media.length}");
    final consistentMedia = media.where((it) {
      final videoExists = File(MediaTool.videoPathOf(it)).existsSync();
      final thumbnailExists = File(MediaTool.thumbnailPathOf(it)).existsSync();
      return videoExists && thumbnailExists;
    }).toList();
    print(
        "[MediaBloc][_inconsistent] consistent media: ${consistentMedia.length}");
    final inconsistentMedia = media
        .where((it) => !consistentMedia.map((cm) => cm.id).contains(it.id))
        .toList();
    print(
        "[MediaBloc][_inconsistent] inconsistent media: ${inconsistentMedia.length}");
    final consistentMediaPaths = consistentMedia
        .expand((it) => [
              MediaTool.thumbnailPathOf(it),
              MediaTool.videoPathOf(it),
            ])
        .toList();
    print(
        "[MediaBloc][_inconsistent] consistent media paths: ${consistentMediaPaths.length}");
    final inconsistentMediaPaths = (await _mediaRepository.mediaFilePaths())
        .where((it) => !consistentMediaPaths.contains(it))
        .toList();
    print(
        "[MediaBloc][_inconsistent] inconsistent media paths: ${inconsistentMediaPaths.length}");
    return InconsistentMediaModel(
      media: inconsistentMedia,
      paths: inconsistentMediaPaths,
    );
  }
}
