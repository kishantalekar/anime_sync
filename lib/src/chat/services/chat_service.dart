import '../../../../secrets/secrets.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatService {
  Future<String> sendMessage(String text) async {
    try {
      final model =
          GenerativeModel(model: 'gemini-pro', apiKey: Secrets.apiKey);
      final content = [Content.text(text)];
      final response = await model.generateContent(content);

      return response.text!;
    } catch (e) {
      return 'Failed to do something';
    }
  }
}
