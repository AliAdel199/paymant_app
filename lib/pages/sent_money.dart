import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../constant.dart';
import '../services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

import '../widgets.dart';

class SentMoneyPage extends StatefulWidget {
  const SentMoneyPage({
    Key? key,
  }) : super(key: key);

  @override
  _SentMoneyPageState createState() => _SentMoneyPageState();
}

class _SentMoneyPageState extends State<SentMoneyPage> {
  TextEditingController reciverController = TextEditingController();
  TextEditingController moneyController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  double? _deviceHeight;
  double? _deviceWidth;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // FirebaseMessaging messaging = FirebaseMessaging();
  Barcode? result;
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    double _textFieldWidth = _deviceWidth! * 0.88;
    return Scaffold(
      backgroundColor: offWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Image.asset('images/previous.png', color: Colors.blueGrey),
              // Put icon of your preference.
              onPressed: () {
                Navigator.pop(context);
                // your method (function),
              },
            );
          },
        ),
        backgroundColor: offWhite,
      ),
      body: Container(
        child: ListView(
          children: [
            SizedBox(
              height: _deviceHeight! * 0.05,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  width: 2.0,
                  color: offWhite,
                )),
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
                width: _deviceWidth! * 0.7,
                height: _deviceHeight! * 0.35,
              ),
            ),
            SizedBox(
              height: _deviceHeight! * 0.05,
            ),
            TextCostomField("معرف المستلم", reciverController, _textFieldWidth),
            SizedBox(
              height: _deviceHeight! * 0.03,
            ),
            TextCostomField("الرصيد", moneyController, _textFieldWidth),
            SizedBox(
              height: _deviceHeight! * 0.03,
            ),
            TextCostomField("ملاحظه", noteController, _textFieldWidth),
            SizedBox(
              height: _deviceHeight! * 0.06,
            ),
            buttonCostomField(
                text: "ارسال",
                onTap: () async {
                  if (reciverController.text.trim() == _auth.currentUser!.uid) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.red,
                      content: Text(
                        " لا يمكن اتمام العملية يرجى التاكد من عنوان المستقبل",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ));
                  } else {
                    setState(() {
                      EasyLoading.show(
                        status: 'loading...',
                        maskType: EasyLoadingMaskType.black,
                      );
                    });

                    await DBService.instance.updateUserBalance(
                        reciverController.text.trim(),
                        double.parse(moneyController.text.trim()),
                        _auth.currentUser!.uid);
                    DBService.instance.updateTransferMsg(
                        context: context,
                        note: noteController.text.trim(),
                        uid: _auth.currentUser!.uid,
                        userID: reciverController.text.trim(),
                        balance: double.parse(moneyController.text.trim()));

                    setState(() {
                      EasyLoading.showSuccess('Great Success!');
                    });

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.green,
                      content: Text(
                        " تم الارسال بنجاح",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ));

                    // print(messaging.getToken());

                  }
                },
                width: _deviceWidth! * 0.5),
          ],
        ),
      ),
    );
  }

//
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      reciverController.text = result!.code!;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
