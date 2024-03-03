import 'package:anime_sync/core/error/failure.dart';
import 'package:dartz/dartz.dart';

typedef ListMap = List<Map<String, dynamic>>;
typedef FutureEither<T> = Future<Either<ApiFailure, T>>;
