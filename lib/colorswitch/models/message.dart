/// A constant way of sending messages to clients
class Message {
  /// Create a message
  Message({
    required this.purpose,
    required this.data,
    required this.clientID,
  });

  /// From Json constructor
  factory Message.fromJson(Map<String, dynamic> message) {
    return Message(
      purpose: message['purpose']! as String,
      data: message['data']! as String,
      clientID: message['clientID']! as String,
    );
  }

  /// What the message is about: can be _colorchange_ or _upgrade_ or _newconn_
  final String purpose;

  /// What the message is about: can be _colorchange_ or _upgrade_ or _newconn_
  final String clientID;

  /// Stringified string that contains the message
  final String data;

  /// Convery object to JSON
  Map<String, String> toJson() {
    return <String, String>{
      'purpose': purpose,
      'clientID': clientID,
      'data': data,
    };
  }
}
