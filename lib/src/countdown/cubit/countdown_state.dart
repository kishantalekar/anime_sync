part of 'countdown_cubit.dart';

/// {@template countdown}
/// CountdownState description
/// {@endtemplate}
sealed class CountdownState extends Equatable {
  /// {@macro countdown}
  const CountdownState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];
}

/// {@template countdown_initial}
/// The initial state of CountdownState
/// {@endtemplate}
class CountdownInitial extends CountdownState {
  /// {@macro countdown_initial}
  const CountdownInitial() : super();
}

class CountdownLoading extends CountdownState {
  const CountdownLoading() : super();
}

class CountdownLoaded extends CountdownState {
  const CountdownLoaded(this.countdownList) : super();

  final List<CountdownModel> countdownList;
}

class CountdownError extends CountdownState {
  const CountdownError(this.failure) : super();
  final ApiFailure failure;

  @override
  List<Object> get props => [failure];
}
