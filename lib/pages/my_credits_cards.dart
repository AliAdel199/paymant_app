//
// import 'package:credit_card/credit_card_widget.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../constant.dart';
// import '../models/model.dart';
// import '../pages/my_add_credit_card_page.dart';
// import '../services/db_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:http/http.dart' as http;
//
// class MyCreditsPage extends StatefulWidget {
//   const MyCreditsPage({
//     Key? key,
//   }) : super(key: key);
//   @override
//   _MyCreditsPageState createState() => _MyCreditsPageState();
// }
//
// class _MyCreditsPageState extends State<MyCreditsPage> {
//   List<bool> isCvvFocused = [];
//
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//   double? _deviceHeight;
//   double? _deviceWidth;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   // FirebaseMessaging messaging = FirebaseMessaging();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//
//     super.initState();
//   }
//
//   @override
//   void reassemble() {
//     // TODO: implement reassemble
//
//     super.reassemble();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _deviceHeight = MediaQuery.of(context).size.height;
//     _deviceWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: offWhite,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         leading: Builder(
//           builder: (BuildContext context) {
//             return IconButton(
//               icon: Image.asset('images/previous.png',color: Colors.blueGrey),
//               // Put icon of your preference.
//               onPressed: () {
//                 Navigator.pop(context);
//                 // your method (function),
//               },
//             );
//           },
//         ),
//         backgroundColor:offWhite,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
//             child: Text("بطاقاتي",
//                 style: TextStyle(
//                     color: textColor, fontSize: 25)),
//           ),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => AddCreditsPage()),
//                   );
//                 },
//                 child: Image.asset(
//                   "images/credit-card.png",
//                   height: _deviceHeight! * 0.11,
//                 ),
//               ),
//               Container(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
//                 child: Text("اضافة بطاقة جديدة",
//                     style: TextStyle(
//                         color:textColor, fontSize: 25)),
//               ),
//             ],
//           ),
//           Expanded(
//             child: StreamBuilder<PaymentModel>(
//                 stream: DBService.instance.getUserData(_auth.currentUser!.uid),
//                 builder: (_context, _snapshot) {
//                   var _userData = _snapshot.data;
//
//                   return _snapshot.hasData
//                       ? Align(
//                           alignment: Alignment.center,
//                           child: ListView.builder(
//                               reverse: true,
//                               itemCount: _userData!.credits!.length,
//                               itemBuilder: (BuildContext _context, int _index) {
//                                 for (int i = 0;
//                                     i < _userData.credits!.length;
//                                     i++) {
//                                   isCvvFocused.add(false);
//                                 }
//
//                                 return GestureDetector(
//                                   onTap: () {
//                                     // ignore: avoid_print
//                                     print(_userData.credits!.length);
//                                     // ignore: avoid_print
//                                     print(isCvvFocused[_index]);
//                                     setState(() {
//                                       if (isCvvFocused[_index] == true) {
//                                         isCvvFocused[_index] = false;
//                                       } else {
//                                         isCvvFocused[_index] = true;
//                                       }
//                                     });
//                                   },
//                                   child: CreditCardWidget(
//                                     cardNumber: _userData.credits![_index]
//                                         ["creditNumber"],
//                                     expiryDate: _userData.credits![_index]
//                                         ["creditDate"],
//                                     cardHolderName: _userData.credits![_index]
//                                         ["holderName"],
//                                     cvvCode: _userData.credits![_index]["vcc"],
//                                     height: 200,
//                                     showBackView: isCvvFocused[_index],
//                                   ),
//                                 );
//                               }))
//                       : const SpinKitWanderingCubes(
//                           color: Colors.blue,
//                           size: 50.0,
//                         );
//                 }),
//           ),
//         ],
//       ),
//     );
//   }
// }
