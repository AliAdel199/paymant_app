//
// import '../api/messaging.dart';
// import '../models/message.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
//
//
// class MessagingWidget extends StatefulWidget {
//   const MessagingWidget({
//     Key? key,
//   }) : super(key: key);
//   @override
//   _MessagingWidgetState createState() => _MessagingWidgetState();
// }
//
// class _MessagingWidgetState extends State<MessagingWidget> {
//   // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//   final TextEditingController titleController =
//       TextEditingController(text: 'Title');
//   final TextEditingController bodyController =
//       TextEditingController(text: 'Body123');
//   final List<Message> messages = [];
//
//   @override
//   void initState() {
//     super.initState();
//
//     // _firebaseMessaging.onTokenRefresh.listen(sendTokenToServer);
//     // _firebaseMessaging.getToken();
//     //
//     // _firebaseMessaging.subscribeToTopic('all');
//     //
//     // _firebaseMessaging.configure(
//     //   onMessage: (Map<String, dynamic> message) async {
//     //     print("onMessage: $message");
//     //     final notification = message['notification'];
//     //     setState(() {
//     //       messages.add(Message(
//     //           title: notification['title'], body: notification['body']));
//     //     });
//     //   },
//     //   onLaunch: (Map<String, dynamic> message) async {
//     //     print("onLaunch: $message");
//     //
//     //     final notification = message['data'];
//     //     setState(() {
//     //       messages.add(Message(
//     //         title: '${notification['title']}',
//     //         body: '${notification['body']}',
//     //       ));
//     //     });
//     //   },
//     //   onResume: (Map<String, dynamic> message) async {
//     //     print("onResume: $message");
//     //   },
//     // );
//     // _firebaseMessaging.requestNotificationPermissions(
//     //     const IosNotificationSettings(sound: true, badge: true, alert: true));
//   }
//
//   @override
//   Widget build(BuildContext context) => ListView(
//         children: [
//           TextFormField(
//             controller: titleController,
//             decoration: const InputDecoration(labelText: 'Title'),
//           ),
//           TextFormField(
//             controller: bodyController,
//             decoration: const InputDecoration(labelText: 'Body'),
//           ),
//           RaisedButton(
//             onPressed: sendNotification,
//             child:const Text('Send notification to all'),
//           ),
//         ]..addAll(messages.map(buildMessage).toList()),
//       );
//
//   // Widget buildMessage(Message message) => ListTile(
//   //       title: Text(message.title),
//   //       subtitle: Text(message.body),
//   //     );
//
//   Future sendNotification() async {
//     // final response = await Messaging.sendToAll(
//     //   title: titleController.text,
//     //   body: bodyController.text,
//     //   // fcmToken: fcmToken,
//     // );
//     //
//     // if (response.statusCode != 200) {
//     //   Scaffold.of(context).showSnackBar(SnackBar(
//     //     content:
//     //         Text('[${response.statusCode}] Error message: ${response.body}'),
//     //   ));
//     // }
//   }
//
//   void sendTokenToServer(String fcmToken) {
//     print('Token: $fcmToken');
//     // send key to your server to allow server to use
//     // this token to send push notifications
//   }
// }
