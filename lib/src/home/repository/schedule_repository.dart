import 'package:anime_sync/core/utils/typedefs.dart';
import 'package:anime_sync/src/home/models/anime_model.dart';
import 'package:anime_sync/src/home/services/schedule_service.dart';
import 'package:dartz/dartz.dart';

class ScheduleRepository {
  const ScheduleRepository({required ScheduleService service})
      : _service = service;

  final ScheduleService _service;
  FutureEither<List<AnimeSchedule>> getSchedules() async {
    final res = await _service.getSchedules();

    return res.fold((l) => left(l), (data) {
      final scheduleList =
          data.map((schedule) => AnimeSchedule.fromJson(schedule)).toList();
      return right(scheduleList);
    });
  }
}
