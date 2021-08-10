import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tchauafasiaplayer/bloc/media/MediaBloc.dart';
import 'package:tchauafasiaplayer/bloc/media/MediaRepository.dart';
import 'package:tchauafasiaplayer/bloc/navigation/NavigationBloc.dart';
import 'package:tchauafasiaplayer/config/BootConfig.dart';

class ProvidersConfig extends StatelessWidget {
  final Widget child;

  ProvidersConfig({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MediaRepository>(
          create: (context) => MediaRepository(box: BootConfig.mediaBox),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NavigationBloc>(
            create: (BuildContext context) => NavigationBloc(context),
          ),
          BlocProvider<MediaBloc>(
            create: (BuildContext context) => MediaBloc(context),
          ),
        ],
        child: child,
      ),
    );
  }
}
