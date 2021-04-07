import 'package:ChatApp/model/user_model.dart';


  List<User> users = [
    User(name: "user 1", phoneNo: 111126731, imageUrl: null),
    User(name: "user 2", phoneNo: 121318113, imageUrl: null),
    User(name: "user 3", phoneNo: 189111341, imageUrl: null),
    User(name: "user 4", phoneNo: 113515129, imageUrl: null)
  ];

class Message {
  final User sender;
  final String time; // Would usually be type DateTime or Firebase Timestamp
  final String text;
  final bool unread;

  Message({
    this.sender,
    this.time,
    this.text,
    this.unread,
  });


  
}
List<Message> chats = [
    Message(
      sender: users[0],
      time: '5:30 PM',
      text: 'Hey, how\'s it going? What did you do today?',
      unread: true,
    ),
    Message(
      sender: users[1],
      time: '4:30 PM',
      text: 'Hey, how\'s it going? What did you do today?',
      unread: true,
    ),
    Message(
      sender: users[2],
      time: '3:30 PM',
      text: 'Hey, how\'s it going? What did you do today?',
      unread: false,
    ),
    Message(
      sender: users[3],
      time: '2:30 PM',
      text: 'Hey, how\'s it going? What did you do today?',
      unread: true,
    ),
  ];
