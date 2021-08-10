import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tchauafasiaplayer/bloc/media/MediaBloc.dart';
import 'package:tchauafasiaplayer/model/MediaModel.dart';
import 'package:tchauafasiaplayer/tool/MediaTool.dart';

class LocalMediaListItem extends StatelessWidget {
  final MediaModel media;

  const LocalMediaListItem({
    required this.media,
  });

  MediaBloc _mediaBloc(BuildContext context) =>
      BlocProvider.of<MediaBloc>(context);

  _delete(BuildContext context) async {
    print("[LocalMediaListItem][_delete]");
    try {
      await _mediaBloc(context).deleteLocalMedia(media);
      print("[LocalMediaListItem][_delete] done");
    } catch (e) {
      print("[LocalMediaListItem][_delete] e: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        Image.file(
          File(MediaTool.thumbnailPathOf(media)),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        Container(
          padding: EdgeInsets.only(left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(media.title ?? "[Sem título]"),
              OutlinedButton(
                onPressed: () => _delete(context),
                child: Text("Excluir"),
              )
            ],
          ),
        )
      ],
    ));
  }
}
