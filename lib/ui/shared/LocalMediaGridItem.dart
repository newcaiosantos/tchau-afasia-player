import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tchauafasiaplayer/model/MediaModel.dart';
import 'package:tchauafasiaplayer/tool/MediaTool.dart';
import 'package:tchauafasiaplayer/ui/shared/PlayerUi.dart';

class LocalMediaGridItem extends StatelessWidget {
  final MediaModel media;

  const LocalMediaGridItem({
    required this.media,
  });

  _play(BuildContext context) async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return PlayerUi(media: media);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _play(context),
      child: Stack(
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
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  media.title ?? "",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
