
import 'package:firebase_auth/firebase_auth.dart';
import '../constant.dart';
import '../models/model.dart';
import '../services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LastTransferPage extends StatefulWidget {
  const LastTransferPage({
    Key? key,
  }) : super(key: key);

  @override
  _LastTransferPageState createState() => _LastTransferPageState();
}

class _LastTransferPageState extends State<LastTransferPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  double? _deviceHeight;
  double? _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Image.asset('images/previous.png'),
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
      body: Builder(
        builder: (BuildContext _context) {
          String timeDate =
              "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";
          print(timeDate);
          return StreamBuilder<PaymentModel>(
            stream: DBService.instance.getUserData(_auth.currentUser!.uid),
            builder: (_context, _snapshot) {
              var _userData = _snapshot.data;

              return _snapshot.hasData
                  ? Align(
                      alignment: Alignment.center,
                      child: ListView.builder(
                          itemCount: _userData!.trans!.length,
                          itemBuilder: (BuildContext _context, int _index) {
                            Timestamp timestamp =
                                _userData.trans![_index]["time"];
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 11,horizontal:25),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(11),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: colorWhite,
                                      ),
                                      width: _deviceWidth! * 0.75,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                           Padding(
                                             padding: const EdgeInsets.only(right: 30),
                                             child: Text(
                                              _userData.trans![_index]["msg"],
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: textColor,
                                              ),
                                              maxLines: 10,
                                              textAlign: TextAlign.right,
                                          ),
                                           ),
                                          Text(
                                            "Note : \n ${_userData.trans![_index]["note"]}",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: textColor,
                                            ),
                                            maxLines: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                        icon: Image.asset(
                                          "images/remove.png",
                                          height: _deviceHeight! * 0.3,
                                        ),
                                        onPressed: () async {
                                          DocumentReference docRef =
                                              FirebaseFirestore.instance
                                                  .collection("Users")
                                                  .doc(_auth.currentUser!.uid);
                                          DocumentSnapshot docs =
                                              await docRef.get();
                                          var data=docs.data();

                                          setState(() {
                                            // List trans = data!["trans"];

                                            docRef.update({
                                              "trans": FieldValue.arrayRemove(
                                                  [_userData.trans![_index]])
                                            });
                                          });
//                                  print("${_userData.trans.indexOf("qqqqqqq")}");
                                        })
                                  ],
                                ),
                              ),
                            );
                          }))
                  : const SpinKitWanderingCubes(
                      color: Colors.blue,
                      size: 50.0,
                    );
            },
          );
        },
      ),
      backgroundColor: offWhite,
    );
  }
}
