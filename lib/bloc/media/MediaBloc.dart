import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tchauafasiaplayer/bloc/media/MediaRepository.dart';
import 'package:tchauafasiaplayer/bloc/media/MediaState.dart';
import 'package:tchauafasiaplayer/model/MediaModel.dart';

class MediaBloc extends Cubit<MediaState> {
  late final MediaRepository _mediaRepository;

  MediaBloc(BuildContext context) : super(MediaState()) {
    _mediaRepository = context.read<MediaRepository>();
  }

  findMedia() async {
    print("[MediaBloc][findMedia]");
    emit(state.copyWith(finding: true));
    try {
      final media = await _mediaRepository.findMedia();
      emit(state.copyWith(
        remoteMedia: media.content,
        finding: false,
      ));
      print("[MediaBloc][findMedia] done");
    } catch (e) {
      print("[MediaBloc][findMedia] e: $e");
      emit(state.copyWith(finding: false));
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
      emit(state.copyWith(
        localMedia: state.remoteMedia + [media],
        downloading: false,
      ));
      print("[MediaBloc][downloadMedia] done");
    } catch (e) {
      print("[MediaBloc][downloadMedia] e: $e");
      emit(state.copyWith(downloading: false));
      throw e;
    }
  }
}
