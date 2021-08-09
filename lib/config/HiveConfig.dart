import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:tchauafasiaplayer/bloc/media/MediaRepository.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveConfig extends StatefulWidget {
  final Widget child;

  HiveConfig({
    required this.child,
  });

  @override
  _HiveConfigState createState() => _HiveConfigState();
}

class _HiveConfigState extends State<HiveConfig> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    Hive.initFlutter("hive_data");
    // Hive.registerAdapter(MediaModelAda);
    Hive.openBox(MediaRepository.boxId);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
