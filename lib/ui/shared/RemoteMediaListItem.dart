import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tchauafasiaplayer/bloc/media/MediaBloc.dart';
import 'package:tchauafasiaplayer/model/MediaModel.dart';

class RemoteMediaListItem extends StatelessWidget {
  final MediaModel media;

  const RemoteMediaListItem({
    required this.media,
  });

  MediaBloc _mediaBloc(BuildContext context) =>
      BlocProvider.of<MediaBloc>(context);

  _download(BuildContext context) async {
    print("[RemoteMediaListItem][_download]");
    try {
      await _mediaBloc(context).downloadMedia(media);
      print("[RemoteMediaListItem][_download] done");
    } catch (e) {
      print("[RemoteMediaListItem][_download] e: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        if (media.thumbnailUrl != null)
          CachedNetworkImage(
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            imageUrl: media.thumbnailUrl!,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error_outline),
          ),
        Container(
          padding: EdgeInsets.only(left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(media.title ?? "[Sem título]"),
              OutlinedButton(
                onPressed: () => _download(context),
                child: Text("Download"),
              )
            ],
          ),
        )
      ],
    ));
  }
}
