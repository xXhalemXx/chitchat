part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  const DashboardState({
    this.currentIndex = 0,
  });
  final int currentIndex;

  DashboardState copyWith({
    int? currentIndex,
  }) {
    return DashboardState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object> get props => [
        currentIndex,
      ];
}
