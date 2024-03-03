import 'package:anime_sync/src/countdown/models/countdown_model.dart';
import 'package:anime_sync/src/countdown/services/countdown_service.dart';

class CountdownRepo {
  CountdownRepo(this._countdownService);
  final CountdownService _countdownService;

  Future<List<CountdownModel>> getCountdowns(String status) async {
    final res = await _countdownService.getCountdowns(status);

    return res.fold((l) {
      print(l.message);
      return [];
    }, (data) {
      final countdownList =
          data.map((countdown) => CountdownModel.fromMap(countdown)).toList();
      return countdownList;
    });
  }
}
