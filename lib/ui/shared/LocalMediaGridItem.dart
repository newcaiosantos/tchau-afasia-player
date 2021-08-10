import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tchauafasiaplayer/bloc/media/MediaBloc.dart';
import 'package:tchauafasiaplayer/model/MediaModel.dart';
import 'package:tchauafasiaplayer/tool/MediaTool.dart';

class LocalMediaGridItem extends StatelessWidget {
  final MediaModel media;

  const LocalMediaGridItem({
    required this.media,
  });

  MediaBloc _mediaBloc(BuildContext context) =>
      BlocProvider.of<MediaBloc>(context);

  _delete(BuildContext context) async {
    print("[LocalMediaGridItem][_delete]");
    try {
      await _mediaBloc(context).deleteLocalMedia(media);
      print("[LocalMediaGridItem][_delete] done");
    } catch (e) {
      print("[LocalMediaGridItem][_delete] e: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.file(
          File(MediaTool.thumbnailPathOf(media)),
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                media.title ?? "",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
