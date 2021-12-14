import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';


class MySample extends StatefulWidget {
  const MySample({Key? key}) : super(key: key);

  @override
  MySampleState createState() => MySampleState();
}

class MySampleState extends State<MySample> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: !useBackgroundImage
              ? const DecorationImage(
            image: ExactAssetImage('assets/bg.png'),
            fit: BoxFit.fill,
          )
              : null,
          color: Colors.black,
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              CreditCardWidget(
                glassmorphismConfig:
                useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                obscureCardNumber: true,
                obscureCardCvv: true,
                isHolderNameVisible: true,
                cardBgColor: Colors.red,
                backgroundImage:
                useBackgroundImage ? 'assets/card_bg.png' : null,
                isSwipeGestureEnabled: true,
                onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
                customCardTypeIcons: <CustomCardTypeIcon>[
                  CustomCardTypeIcon(
                    cardType: CardType.mastercard,
                    cardImage: Image.asset(
                      'assets/mastercard.png',
                      height: 48,
                      width: 48,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      CreditCardForm(
                        formKey: formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumber: cardNumber,
                        cvvCode: cvvCode,
                        isHolderNameVisible: true,
                        isCardNumberVisible: true,
                        isExpiryDateVisible: true,
                        cardHolderName: cardHolderName,
                        expiryDate: expiryDate,
                        themeColor: Colors.blue,
                        textColor: Colors.white,
                        cardNumberDecoration: InputDecoration(
                          labelText: 'Number',
                          hintText: 'XXXX XXXX XXXX XXXX',
                          hintStyle: const TextStyle(color: Colors.white),
                          labelStyle: const TextStyle(color: Colors.white),
                          focusedBorder: border,
                          enabledBorder: border,
                        ),
                        expiryDateDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.white),
                          labelStyle: const TextStyle(color: Colors.white),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'Expired Date',
                          hintText: 'XX/XX',
                        ),
                        cvvCodeDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.white),
                          labelStyle: const TextStyle(color: Colors.white),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                        cardHolderDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.white),
                          labelStyle: const TextStyle(color: Colors.white),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'Card Holder',
                        ),
                        onCreditCardModelChange: onCreditCardModelChange,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Glassmorphism',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Switch(
                            value: useGlassMorphism,
                            inactiveTrackColor: Colors.grey,
                            activeColor: Colors.white,
                            activeTrackColor: Colors.green,
                            onChanged: (bool value) => setState(() {
                              useGlassMorphism = value;
                            }),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Card Image',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Switch(
                            value: useBackgroundImage,
                            inactiveTrackColor: Colors.grey,
                            activeColor: Colors.white,
                            activeTrackColor: Colors.green,
                            onChanged: (bool value) => setState(() {
                              useBackgroundImage = value;
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          primary: const Color(0xff1b447b),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(12),
                          child: const Text(
                            'Validate',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'halter',
                              fontSize: 14,
                              package: 'flutter_credit_card',
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            print('valid!');
                          } else {
                            print('invalid!');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}


//
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:credit_card/credit_card_model.dart';
// import 'package:credit_card/credit_card_widget.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// import '../constant.dart';
// import '../services/db_service.dart';
// import '../widgets.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
//
// class AddCreditCard extends StatefulWidget {
//   const AddCreditCard({
//     Key? key,
//      this.cardNumber,
//      this.expiryDate,
//      this.cardHolderName,
//      this.cvvCode,
//     @required this.onCreditCardModelChange,
//     this.themeColor,
//     this.textColor = Colors.black,
//     this.cursorColor,
//   }) : super(key: key);
//
//   final String? cardNumber;
//   final String? expiryDate;
//   final String? cardHolderName;
//   final String? cvvCode;
//   final void Function(CreditCardModel)? onCreditCardModelChange;
//   final Color? themeColor;
//   final Color? textColor;
//   final Color? cursorColor;
//
//   @override
//   _AddCreditCardState createState() => _AddCreditCardState();
// }
//
// class _AddCreditCardState extends State<AddCreditCard> {
//   String? cardNumber;
//   String? expiryDate;
//   String? cardHolderName;
//   String? cvvCode;
//   bool isCvvFocused = false;
//   Color? themeColor;
//
//   void Function(CreditCardModel)? onCreditCardModelChange;
//   CreditCardModel? creditCardModel;
//
//   final MaskedTextController _cardNumberController =
//       MaskedTextController(mask: '0000 0000 0000 0000');
//   final TextEditingController _expiryDateController =
//       MaskedTextController(mask: '00/00');
//   final TextEditingController _cardHolderNameController =
//       TextEditingController();
//   final TextEditingController _cvvCodeController =
//       MaskedTextController(mask: '0000');
//
//   FocusNode cvvFocusNode = FocusNode();
//
//   void textFieldFocusDidChange() {
//     creditCardModel!.isCvvFocused = cvvFocusNode.hasFocus;
//     onCreditCardModelChange!(creditCardModel!);
//   }
//
//   void createCreditCardModel() {
//     cardNumber = widget.cardNumber ?? '';
//     expiryDate = widget.expiryDate ?? '';
//     cardHolderName = widget.cardHolderName ?? '';
//     cvvCode = widget.cvvCode ?? '';
//
//     creditCardModel = CreditCardModel(
//         cardNumber, expiryDate, cardHolderName, cvvCode, isCvvFocused);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     createCreditCardModel();
//
//     onCreditCardModelChange = widget.onCreditCardModelChange;
//
//     cvvFocusNode.addListener(textFieldFocusDidChange);
//
//     _cardNumberController.addListener(() {
//       setState(() {
//         cardNumber = _cardNumberController.text;
//         creditCardModel!.cardNumber = cardNumber;
//         onCreditCardModelChange!(creditCardModel!);
//       });
//     });
//
//     _expiryDateController.addListener(() {
//       setState(() {
//         expiryDate = _expiryDateController.text;
//         creditCardModel!.expiryDate = expiryDate;
//         onCreditCardModelChange!(creditCardModel!);
//       });
//     });
//
//     _cardHolderNameController.addListener(() {
//       setState(() {
//         cardHolderName = _cardHolderNameController.text;
//         creditCardModel!.cardHolderName = cardHolderName;
//         onCreditCardModelChange!(creditCardModel!);
//       });
//     });
//
//     _cvvCodeController.addListener(() {
//       setState(() {
//         cvvCode = _cvvCodeController.text;
//         creditCardModel!.cvvCode = cvvCode;
//         onCreditCardModelChange!(creditCardModel!);
//       });
//     });
//   }
//
//   @override
//   void didChangeDependencies() {
//     themeColor = widget.themeColor ?? Theme.of(context).primaryColor;
//     super.didChangeDependencies();
//   }
//
//   double? _deviceHeight;
//   double? _deviceWidth;
//  final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     _deviceHeight = MediaQuery.of(context).size.height;
//     _deviceWidth = MediaQuery.of(context).size.width;
//     return Theme(
//       data: ThemeData(
//         primaryColor: themeColor!.withOpacity(0.8),
//         primaryColorDark: themeColor,
//       ),
//       child: Form(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 4.0, horizontal: 30),
//               child: Text("credit Card Number",
//                   style: TextStyle(color:textColor)),
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               margin: const EdgeInsets.only(left: 16, top: 1, right: 16),
//               child: creditCardTextField('xxxx xxxx xxxx xxxx',
//                   _cardNumberController, _deviceWidth! * 0.85),
//             ),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 4.0, horizontal: 10),
//                         child: Text("Expired",
//                             style: TextStyle(
//                                 color: textColor)),
//                       ),
//                       creditCardTextField(
//                           'MM/YY', _expiryDateController, _deviceWidth! * 0.25),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   width: _deviceWidth! * 0.28,
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
//                   child: Column(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 4.0, horizontal: 5),
//                         child: Text("Vcc",
//                             style: TextStyle(
//                                 color: textColor)),
//                       ),
//                       creditCardTextField(
//                           'XXXX', _cvvCodeController, _deviceWidth! * 0.25),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 4.0, horizontal: 15),
//                     child: Text("Holder Name",
//                         style:
//                             TextStyle(color: textColor)),
//                   ),
//                   creditCardTextField('Card Holder', _cardHolderNameController,
//                       _deviceWidth! * 0.85),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: _deviceHeight! * 0.05,
//             ),
//             Center(
//               child: buttonCostomField(
//                   text: "Add Card",
//                   width: _deviceWidth! * 0.85,
//                   onTap: () async {
//
//                  await  DBService.instance.addCreditCard(
//                           uid: _auth.currentUser!.uid,
//                           creditNumber: _cardNumberController.text,
//                           creditDate: _expiryDateController.text,
//                           holderName: _cardHolderNameController.text,
//                           vcc: _cvvCodeController.text);
//                  AwesomeDialog(
//                    context: context,
//                    headerAnimationLoop: false,
//                    dialogType: DialogType.SUCCES,
//                    animType: AnimType.BOTTOMSLIDE,
//                    title: 'اضافة بطاقة',
//                    desc:
//                    'تمت عملية ىالاضافة بنجاح ..',
//                  ).show();
//
//                   }),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
