

import '../widgets.dart';
import '../models/message.dart';
import '../pages/last_transfer_page.dart';
import '../pages/my_credits_cards.dart';
import '../pages/scan_me_page.dart';
import '../pages/sent_money.dart';
import '../services/db_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../models/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../constant.dart';
import 'add_cridet_card.dart';


class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);
  // FirebaseMessaging messaging = FirebaseMessaging();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore userdata = FirebaseFirestore.instance;

  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final TextEditingController titleController =
      TextEditingController(text: 'Title');
  final TextEditingController bodyController =
      TextEditingController(text: 'Body123');
  final List<Message> messages = [];

  double? _deviceHeight;

  double balance = 0.0;
  double? _deviceWidth;

  void updateBalance() async {
    DocumentReference _docRef =
        userdata.collection("Users").doc(_auth.currentUser!.uid);
    DocumentSnapshot _docSnap = await _docRef.get();
    var documentStream = await FirebaseFirestore.instance.collection('Users').doc(_auth.currentUser!.uid).get();
    documentStream.data()!['balance'];
if(documentStream.data()!=null){
if(mounted){
  setState(() {
    balance = double.parse(documentStream.data()!['balance'].toString());
  });
}
}




  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      updateBalance();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    updateBalance();


    // _firebaseMessaging.onTokenRefresh.listen(sendTokenToServer);
    // _firebaseMessaging.onTokenRefresh.listen(sendTokenToServer);
    // _firebaseMessaging.getToken();
    // _firebaseMessaging.subscribeToTopic('all');
    // _firebaseMessaging.subscribeToTopic(_auth.currentUser.uid);
    // _firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    updateBalance();
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     final notification = message['notification'];
    //     setState(() {
    //       showAlertDailogOnCallBack(notification['title'], notification['body'],
    //           DialogType.SUCCES, context);
    //       messages.add(Message(
    //           title: notification['title'], body: notification['body']));
    //     });
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     final notification = message['data'];
    //     setState(() {
    //       showAlertDailogOnCallBack(notification['title'], notification['body'],
    //           DialogType.SUCCES, context);
    //       messages.add(Message(
    //         title: '${notification['title']}',
    //         body: '${notification['body']}',
    //       ));
    //     });
    //   },
    //   onResume: (Map<String, dynamic> message) async {},
    // );
//
    return _profilePageUI();
  }

  Widget _profilePageUI() {
    return AnimatedContainer(
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor)
          ..rotateY(isDrawerOpen ? -0.5 : 0),
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
            color: offWhite,
            borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
        child: Builder(
          builder: (BuildContext _context) {
            return StreamBuilder<PaymentModel>(
              stream: DBService.instance.getUserData(_auth.currentUser!.uid),
              builder: (_context, _snapshot) {
                updateBalance();
                var _userData = _snapshot.data;
                return
                  _snapshot.hasData
                      ?
                  SingleChildScrollView(
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const SizedBox(
                                height: 50,
                              ),
                              Container(
                                margin:const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    isDrawerOpen
                                        ? IconButton(
                                            icon:const Icon(
                                              Icons.arrow_back_ios,
                                              color: Colors.redAccent,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                xOffset = 0;
                                                yOffset = 0;
                                                scaleFactor = 1;
                                                isDrawerOpen = false;
                                              });
                                            },
                                          )
                                        : IconButton(
                                            icon:
                                                Image.asset("images/menu.png"),
                                            onPressed: () {
                                              setState(() {
                                                xOffset = 230;
                                                yOffset = 150;
                                                scaleFactor = 0.6;
                                                isDrawerOpen = true;
                                              });
                                            }),
                                  ],
                                ),
                              ),
                              userImageWidget(_userData!.image!, _userData.name!),
                          const    SizedBox(
                                height: 10,
                              ),
                              _userBalance(_userData.balance),
                           const   SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _squerButton("أرسال اموال", "images/tran.png",
                                      () {
                                    Navigator.push(
                                      _context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const   SentMoneyPage()),
                                    );
                                  }),
                                  const   SizedBox(
                                    width: 30,
                                  ),
                                  _squerButton("معلوماتي", "images/scan.png",
                                      () {
                                    Navigator.push(
                                      _context,
                                      MaterialPageRoute(
                                          builder: (context) => const ScanMePage()),
                                    );
                                  })
                                ],
                              ),
                              const  SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _squerButton("بطاقاتي", "images/credits.png",
                                      () {
                                    Navigator.push(
                                      _context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const    MySample()),
                                    );
                                  }),
                                  const  SizedBox(
                                    width: 30,
                                  ),
                                  _squerButton("الاشعارات", "images/note.png",
                                      () {
                                    Navigator.push(
                                      _context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const    LastTransferPage()),
                                    );
                                  })
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      )
                    : GestureDetector(onTap: (){
                      setState(() {

                      });
                },
                      child:const SpinKitSquareCircle(
                          color: Colors.blue,
                          size: 50.0,
                        ),
                    );
              },
            );
          },
        ));
  }

  Widget _userBalance(var _balance) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.white),
      width: _deviceWidth! * 0.9,
      height: _deviceHeight! * 0.2,
      child: ListView(
        children: [
          const   SizedBox(
            height: 10,
          ),
          const Center(
            child: Text(
              "الرصيد الحالي",
              style: TextStyle(fontSize: 25, fontFamily: "ReemKufi"),
            ),
          ),
          const  SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
             _balance==null?"0.0": "\$ $_balance",
              style:const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _squerButton(String text, String image, VoidCallback ontap) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.white),
        width: _deviceWidth! * 0.43,
        height: _deviceHeight! * 0.24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const SizedBox(
              height: 5,
            ),
            Center(
              child: Image.asset(
                image,
                height: _deviceHeight! * 0.16,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(text,
                style:const TextStyle(
                    fontFamily: "ReemKufi",
                    fontSize: 20,
                    color: Color.fromRGBO(28, 28, 28, 1))),
          ],
        ),
      ),
    );
  }

  void sendTokenToServer(String fcmToken) {}

  void showAlertDailogOnCallBack(
      String title, String msg, DialogType dialogType, BuildContext context) {
    AwesomeDialog(
      context: context,
      headerAnimationLoop: false,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: msg,
    ).show();
  }
}
