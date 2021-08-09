import 'package:equatable/equatable.dart';

class NavigationState extends Equatable {
  final int uiIndex;

  NavigationState({
    this.uiIndex = 0,
  });

  @override
  List<Object> get props => [uiIndex];

  NavigationState copyWith({
    int? uiIndex,
  }) {
    return NavigationState(
      uiIndex: uiIndex ?? this.uiIndex,
    );
  }
}
