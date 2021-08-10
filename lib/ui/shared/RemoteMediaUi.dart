import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tchauafasiaplayer/bloc/media/MediaBloc.dart';
import 'package:tchauafasiaplayer/bloc/media/MediaState.dart';
import 'package:tchauafasiaplayer/ui/shared/RemoteMediaListItem.dart';

class RemoteMediaUi extends StatelessWidget {
  MediaBloc _mediaBloc(BuildContext context) {
    return BlocProvider.of<MediaBloc>(context);
  }

  _refreshMedia(BuildContext context) async {
    try {
      await _mediaBloc(context).findRemoteMedia();
    } catch (e) {
      print("[RemoteMediaUi][_refreshMedia] e: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Remote media"),
              SizedBox(width: 8),
              OutlinedButton(
                onPressed: () => _refreshMedia(context),
                child: BlocBuilder<MediaBloc, MediaState>(
                  builder: (context, state) {
                    return Text(state.finding ? "Atualizando..." : "Atualizar");
                  },
                ),
              )
            ],
          ),
          Expanded(
            child: BlocBuilder<MediaBloc, MediaState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.remoteMedia.length,
                  itemBuilder: (context, index) {
                    final media = state.remoteMedia[index];
                    return RemoteMediaListItem(media: media);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
