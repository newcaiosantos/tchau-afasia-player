import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tchauafasiaplayer/bloc/media/MediaBloc.dart';
import 'package:tchauafasiaplayer/bloc/media/MediaState.dart';
import 'package:tchauafasiaplayer/ui/SettingsUi.dart';
import 'package:tchauafasiaplayer/ui/shared/LocalMediaGridItem.dart';

class GridUi extends StatelessWidget {
  _goToSettings(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return SettingsUi();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _goToSettings(context),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: BlocBuilder<MediaBloc, MediaState>(
            builder: (context, mediaState) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                ),
                itemCount: mediaState.localMedia.length,
                itemBuilder: (context, index) {
                  final media = mediaState.localMedia[index];
                  return LocalMediaGridItem(media: media);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
