import 'dart:convert';

import 'package:anime_sync/core/error/failure.dart';
import 'package:anime_sync/core/utils/typedefs.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

const url = "http://127.0.0.1:8000/countdown";

class CountdownService {
  FutureEither<List<Map<String, dynamic>>> getCountdowns(String genre) async {
    try {
      final res = await http.get(Uri.parse('$url/$genre'));

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(res.body);

        final List<Map<String, dynamic>> data =
            jsonData['cdlist'].cast<Map<String, dynamic>>();

        return right(data);
      } else {
        return left(ApiFailure(
            message: 'failed to load the resources', stackTrace: 'stackTrace'));
      }
    } catch (e, st) {
      print("$e,$st ");
      return left(ApiFailure(message: e.toString(), stackTrace: st.toString()));
    }
  }
}
