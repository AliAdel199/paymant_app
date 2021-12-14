
import 'package:flutter/cupertino.dart';
import '../constant.dart';

import '../models/model.dart';
import '../services/db_service.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qr_flutter/qr_flutter.dart';


class ScanMePage extends StatefulWidget {
  const ScanMePage({
    Key? key,
  }) : super(key: key);
  @override
  _ScanMePageState createState() => _ScanMePageState();
}

class _ScanMePageState extends State<ScanMePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  double? _deviceHeight;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    User? user = _auth.currentUser;
    return Scaffold(key: _scaffoldKey,
      backgroundColor: offWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Image.asset('images/previous.png',color: Colors.blueGrey),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Builder(
          builder: (BuildContext _context) {
            return StreamBuilder<PaymentModel>(
                stream: DBService.instance.getUserData(_auth.currentUser!.uid),
                builder: (_context, _snapshot) {
                  var _userData = _snapshot.data;
                  return _snapshot.hasData
                      ? ListView(

                          children: [
                            SizedBox(height:_deviceHeight! *0.02 ,),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    icon: Image.asset(
                                      "images/files.png",
                                      height: 30,
                                    ),
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(
                                          text: _auth.currentUser!.uid));
                                    },
                                  ),
                               const   SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "ID : ${_auth.currentUser!.uid}",
                                    style: TextStyle(
                                        color: textColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height:_deviceHeight! * 0.02 ,),
                            Center(
                              child: QrImage(
                                data: user!.uid,
                                version: QrVersions.auto,
                                size: 250.0,
                                backgroundColor: Colors.white,
                              ),
                            ),
                            SizedBox(height:_deviceHeight!*0.03 ,),
                            const Divider(
                              color: Colors.white,
                            ),SizedBox(height:_deviceHeight!*0.03 ,),
                            Text("Name : \n${_userData!.name}",
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 20)),SizedBox(height:_deviceHeight!*0.05 ,),
                            Text("Email : \n${_userData.email}",
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 20)),


                          ],
                        )
                      : const SpinKitWanderingCubes(
                          color: Colors.blue,
                          size: 50.0,
                        );
                });
          },
        ),
      ),
    );
  }
}
