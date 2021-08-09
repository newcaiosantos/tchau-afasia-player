import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tchauafasiaplayer/ui/SettingsUi.dart';

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
    return Scaffold(
      body: Center(
        child: OutlinedButton(
          onPressed: () {
            _goToSettings(context);
          },
          child: Text("Configurações"),
        ),
      ),
    );
  }
}
