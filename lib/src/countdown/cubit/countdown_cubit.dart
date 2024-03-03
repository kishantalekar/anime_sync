import 'dart:async';

import 'package:anime_sync/core/error/failure.dart';
import 'package:anime_sync/src/countdown/models/countdown_model.dart';
import 'package:anime_sync/src/countdown/repository/countdown_repository.dart';
import 'package:anime_sync/src/countdown/services/countdown_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'countdown_state.dart';

class CountdownCubit extends Cubit<CountdownState> {
  CountdownCubit() : super(const CountdownInitial());
  final CountdownRepo _countdownRepo = CountdownRepo(CountdownService());

  FutureOr<void> getCountdowns(String status) async {
    emit(const CountdownLoading());

    final countdownList = await _countdownRepo.getCountdowns(status);

    emit(CountdownLoaded(countdownList));
  }
}
