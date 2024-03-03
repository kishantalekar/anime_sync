import 'package:anime_sync/core/error/failure.dart';
import 'package:anime_sync/src/home/models/anime_model.dart';
import 'package:anime_sync/src/home/repository/schedule_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ScheduleRepository repository;
  HomeCubit(this.repository) : super(const HomeInitial());

  Future<void> getSchedules() async {
    emit(const HomeLoading());

    final result = await repository.getSchedules();

    result.fold((failure) => emit(HomeError(failure)),
        (schedules) => emit(HomeLoaded(schedules)));
  }

  void setActive(int index) {
    emit(const HomeLoading());
  }
}
