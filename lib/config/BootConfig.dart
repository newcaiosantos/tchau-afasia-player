import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tchauafasiaplayer/bloc/media/MediaRepository.dart';
import 'package:tchauafasiaplayer/model/MediaModel.dart';

class BootConfig extends StatefulWidget {
  final Widget child;
  static late Box<MediaModel> mediaBox;
  static late Directory mediaDir;

  BootConfig({
    required this.child,
  });

  @override
  _BootConfigState createState() => _BootConfigState();
}

class _BootConfigState extends State<BootConfig> {
  bool _initOk = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    await _initDirs();
    await _initHive();
    setState(() {
      _initOk = true;
    });
  }

  _initDirs() async {
    BootConfig.mediaDir = await _mediaDir();
  }

  _mediaDir() async {
    final appDocsDir = await getApplicationDocumentsDirectory();
    final mediaDir = Directory('${appDocsDir.path}/_media');
    final dirExists = await mediaDir.exists();
    if (!dirExists) await mediaDir.create();
    return mediaDir;
  }

  _initHive() async {
    await Hive.initFlutter("hive_data");
    Hive.registerAdapter(MediaModelAdapter());
    BootConfig.mediaBox = await Hive.openBox(MediaRepository.boxId);
  }

  @override
  Widget build(BuildContext context) {
    return _initOk
        ? widget.child
        : MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text("Incializando..."),
              ),
            ),
          );
  }
}
