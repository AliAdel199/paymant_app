//
// import 'package:credit_card/credit_card_model.dart';
// import 'package:credit_card/credit_card_widget.dart';
// import '../constant.dart';
// import '../pages/add_cridet_card.dart';
// import 'package:flutter/material.dart';
//
// class AddCreditsPage extends StatefulWidget {
//   AddCreditsPage({
//     Key? key,
//   }) : super(key: key);
//   @override
//   _AddCreditsPageState createState() => _AddCreditsPageState();
// }
//
// class _AddCreditsPageState extends State<AddCreditsPage> {
//   String? cardNumber = '';
//   String expiryDate = '';
//   String cardHolderName = '';
//   String cvvCode = '';
//   bool isCvvFocused = false;
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: offWhite,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         leading: Builder(
//           builder: (BuildContext context) {
//             return IconButton(
//               icon: Image.asset('images/previous.png',color: Colors.blueGrey,),
//               // Put icon of your preference.
//               onPressed: () {
//                 setState(() {
//                   Navigator.pop(context);
//                 });
//                 // your method (function),
//               },
//             );
//           },
//         ),
//         backgroundColor: offWhite,
//       ),
//       body: Column(
//         children: [
//           CreditCardWidget(
//             cardNumber: cardNumber,
//             expiryDate: expiryDate,
//             cardHolderName: cardHolderName,
//             cvvCode: cvvCode,
//             height: 200,
//             showBackView: isCvvFocused,
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: AddCreditCard(
//                 onCreditCardModelChange: onCreditCardModelChange,
//
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   void onCreditCardModelChange(CreditCardModel creditCardModel) {
//     setState(() {
//       cardNumber = creditCardModel.cardNumber;
//       expiryDate = creditCardModel.expiryDate;
//       cardHolderName = creditCardModel.cardHolderName;
//       cvvCode = creditCardModel.cvvCode;
//       isCvvFocused = creditCardModel.isCvvFocused;
//     });
//
//   }
// }
