import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:tchauafasiaplayer/config/HiveConfig.dart';
import 'package:tchauafasiaplayer/config/ProvidersConfig.dart';
import 'package:tchauafasiaplayer/ui/GridUi.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return HiveConfig(
      child: ProvidersConfig(
        child: MaterialApp(
          home: GridUi(),
        ),
      ),
    );
  }
}
