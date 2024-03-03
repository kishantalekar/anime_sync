import 'package:anime_sync/src/home/home.dart';
import 'package:anime_sync/src/home/repository/schedule_repository.dart';
import 'package:anime_sync/src/home/services/schedule_service.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    ..registerFactory(() => HomeCubit(sl.get()))
    ..registerLazySingleton(() => ScheduleRepository(service: sl.get()))
    ..registerLazySingleton(() => const ScheduleService());
}
