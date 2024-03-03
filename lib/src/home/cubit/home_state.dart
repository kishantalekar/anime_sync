part of 'home_cubit.dart';

/// {@template home_state}
/// HomeState description
/// {@endtemplate}
sealed class HomeState extends Equatable {
  /// {@macro home_state}
  const HomeState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];
}

/// {@template home_initial}
/// The initial state of HomeState
/// {@endtemplate}
class HomeInitial extends HomeState {
  /// {@macro home_initial}
  const HomeInitial() : super();
}

class HomeLoading extends HomeState {
  const HomeLoading() : super();
}

class HomeLoaded extends HomeState {
  const HomeLoaded(this.schedules) : super();

  final List<AnimeSchedule> schedules;
}

class HomeError extends HomeState {
  const HomeError(this.failure);

  final ApiFailure failure;

  @override
  List<Object> get props => [failure];
}
