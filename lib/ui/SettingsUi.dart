import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tchauafasiaplayer/ui/shared/LocalMediaUi.dart';
import 'package:tchauafasiaplayer/ui/shared/RemoteMediaUi.dart';

class SettingsUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Configurações")),
      body: Row(
        children: [
          Expanded(child: RemoteMediaUi()),
          VerticalDivider(),
          Expanded(child: LocalMediaUi()),
        ],
      ),
    );
  }
}
