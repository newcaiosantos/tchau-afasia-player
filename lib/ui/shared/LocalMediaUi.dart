import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tchauafasiaplayer/bloc/media/MediaBloc.dart';
import 'package:tchauafasiaplayer/bloc/media/MediaState.dart';
import 'package:tchauafasiaplayer/ui/shared/LocalMediaListItem.dart';

class LocalMediaUi extends StatelessWidget {
  MediaBloc _mediaBloc(BuildContext context) =>
      BlocProvider.of<MediaBloc>(context);

  _deleteInconsistent(BuildContext context) async {
    print("[LocalMediaUi][_deleteInconsistent]");
    try {
      await _mediaBloc(context).deleteInconsistent();
      print("[LocalMediaUi][_deleteInconsistent] done");
    } catch (e) {
      print("[]LocalMediaUi[_deleteInconsistent] e: $e");
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
              Text("Local media"),
              SizedBox(width: 8),
              OutlinedButton(
                onPressed: () => _deleteInconsistent(context),
                child: Text("Remover inconsistências"),
              )
            ],
          ),
          Expanded(
            child: BlocBuilder<MediaBloc, MediaState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.localMedia.length,
                  itemBuilder: (context, index) {
                    final media = state.localMedia[index];
                    return LocalMediaListItem(media: media);
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
