class MessageModel {
  String text;
  String sender;
  String receiver;
  String dateTime;


  MessageModel({
    required this.sender,
    required this.text,
    required this.dateTime,
    required this.receiver,
  });

  static MessageModel fromJason(Map<String, dynamic> jason) {
    return MessageModel(
        text: jason['text'],
        sender: jason['sender'],
        receiver: jason['receiver'],
        dateTime: jason['dateTime'],
    );
  }

  Map<String, dynamic> toMap() => {
        'text': text,
        'dateTime': dateTime,
        'sender': sender,
        'receiver': receiver,
      };
}
