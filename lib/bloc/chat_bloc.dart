import 'dart:async';

import 'package:demo_screen/models/chat_model.dart';

class ChatBloc {
  // Sample data
  List<Map<String, String>> sentMessages = [
    {
      "sender": "Surya Karan",
      "message":
          "We need not to release the 1st version of the app with all feature. It's good to enter the market with MVP rather than late with all features",
    },
    {
      "sender": "Sara S.",
      "message":
          "We need aggressive marketing in social media to create the buzz for the project"
    }
  ];
  List<Map<String, String>> receivedMessages = [
    {
      "receiver": "",
      "message":
          "We need not to release the 1st version of the app with all feature. It's good to enter the market with MVP rather than late with all features",
    },
    {
      "receiver": "",
      "message": "Shouldn't we go for both light and dark theme for the app"
    }
  ];
  // controller
  final StreamController<ChatData> _chatStreamController =
      StreamController<ChatData>();

  //stream
  Stream<ChatData> get chatStream => _chatStreamController.stream;

  //sink
  StreamSink<ChatData> get chatSink => _chatStreamController.sink;

  ChatBloc() {
    final ChatData chatData = ChatData(sentMessages, receivedMessages);
    _chatStreamController.add(chatData);
  }

  dispose() {
    _chatStreamController.close();
  }
}
