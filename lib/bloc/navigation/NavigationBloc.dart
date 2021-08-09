import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tchauafasiaplayer/bloc/navigation/NavigationState.dart';

class NavigationBloc extends Cubit<NavigationState> {
  NavigationBloc(BuildContext context) : super(NavigationState());

  emitUiIndex(int uiIndex) {
    emit(state.copyWith(uiIndex: uiIndex));
  }
}
