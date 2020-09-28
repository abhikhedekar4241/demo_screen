class ChatData {
  List<Map<String, String>> _receivedMessages;
  List<Map<String, String>> _sentMessages;

  ChatData(this._sentMessages, this._receivedMessages);

  //setters

  set receivedMessages(List<Map<String, String>> receivedMessages) {
    _receivedMessages = receivedMessages;
  }

  set sentMessages(List<Map<String, String>> sentMessages) {
    _sentMessages = sentMessages;
  }

  //getters
  List<Map<String, String>> get receivedMessages => this._receivedMessages;
  List<Map<String, String>> get sentMessages => this._sentMessages;
}
