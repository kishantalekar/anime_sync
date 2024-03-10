import 'package:anime_sync/src/chat/chat.dart';

import '../../../../secrets/secrets.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatService {
  Future<String> sendMessage(String query, List<Message> messages) async {
    try {
      final model = GenerativeModel(
        model: 'gemini-pro',
        apiKey: Secrets.apiKey,
      );
      final history = messages
          .map((message) => message.sender == "User"
              ? Content.text(message.content)
              : Content.model([TextPart(message.content)]))
          .toList();

      final chat = model.startChat(
        history: history,
      );
      query +=
          'For the above query,it should be related to anime otherwise decline the query with appropriate message.';
      final content = Content.text(query);

      final response = await chat.sendMessage(content);
      print("response.text ${response.text}");
      return response.text!;
    } catch (e) {
      print(e);
      return 'Something went wrong,deal with it';
    }
  }
}
