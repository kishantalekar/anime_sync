import 'dart:convert';
import 'package:anime_sync/core/error/failure.dart';
import 'package:anime_sync/core/url.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

final String remoteUrl = Url.remoteUrl;
final String scheduleUrl = "$remoteUrl/schedules";

// const String scheduleUrl = "http://10.0.2.2:8000/schedules";
class ScheduleService {
  const ScheduleService();
  Future<Either<ApiFailure, List<Map<String, dynamic>>>> getSchedules() async {
    try {
      print(scheduleUrl);
      final res = await http.get(Uri.parse(scheduleUrl));

      if (res.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(res.body);
        final List<Map<String, dynamic>> data =
            jsonData.cast<Map<String, dynamic>>();

        return right(data);
      } else {
        return left(
            ApiFailure(message: 'Failed to load schedules', stackTrace: ''));
      }
    } catch (e, st) {
      return left(ApiFailure(message: e.toString(), stackTrace: st.toString()));
    }
  }
}
