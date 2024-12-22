class MessageModel {
  String text;
  String sender;
  String receiver;
  String dateTime;
  bool isSeen = false;

  MessageModel({
    required this.sender,
    required this.text,
    required this.dateTime,
    required this.receiver,
    this.isSeen = false,
  });

  static MessageModel fromJason(Map<String, dynamic> jason) {
    return MessageModel(
      text: jason['text'],
      sender: jason['sender'],
      receiver: jason['receiver'],
      dateTime: jason['dateTime'],
      isSeen: jason['isSeen'],
    );
  }

  Map<String, dynamic> toMap() => {
        'text': text,
        'dateTime': dateTime,
        'sender': sender,
        'receiver': receiver,
        'isSeen': isSeen,
      };
}
