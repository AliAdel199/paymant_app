
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../api/messaging.dart';
import 'package:flutter/material.dart';

import '../models/model.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

class DBService {
  static DBService instance = DBService();

  FirebaseFirestore? _db;
  var balance;
  // FirebaseMessaging messaging = FirebaseMessaging();

  DBService() {
    _db = FirebaseFirestore.instance;
  }

  String? _userCollection = "Users";

  Future<void> createUserInDB(
      String? _uid, String? _name, String? _email, String? _imageURL) async {
    // var token = await messaging.getToken();
    try {



      return await _db!.collection(_userCollection!).doc(_uid).set({
        "name": _name,
        "email": _email,
        "image": _imageURL,
        "balance": 1000.0,
        "trans": [],
        "credits": [],
        // "token": token
      });

    } catch (e) {
      print(e);
    }
  }

  getUserImage(String? userID) async {
    var userImage = await _db!.collection(_userCollection!).doc(userID).get();
    return userImage.data()!["image"];
  }

//#######################################################################################//
//                             updateUserBalance
//#######################################################################################//
  Future<void> updateUserNameAndImage(String? _userID,String? name, String? imagurl) async {
    var _ref1 = _db!.collection(_userCollection!).doc(_userID);
    _ref1.update({
      "name":name,
      "image":imagurl
    });
  }

  Future<void> updateUserBalance(String? _userID, balance, String? uid) async {
    var reciverBalanc =
        await _db!.collection(_userCollection!).doc(_userID).get();
    var myBalance = await _db!.collection(_userCollection!).doc(uid).get();

    var oldMyBalance = myBalance.data()!["balance"];
    var newMyBalance = oldMyBalance - balance;

    var oldreciverBalanc = reciverBalanc.data()!["balance"];
    var newOldReciverBalanc = oldreciverBalanc + balance;
    var _ref2 = _db!.collection(_userCollection!).doc(uid);
    _ref2.update({"balance": newMyBalance});
    var _ref1 = _db!.collection(_userCollection!).doc(_userID);
    return _ref1.update({"balance": newOldReciverBalanc});
  }

//#######################################################################################//

  //#######################################################################################//
//                             updateTransferMsg
//#######################################################################################//
  Future<void> updateTransferMsg(
      {String? userID, balance, String? note, String? uid, context}) async {
    Stream collectionStream = FirebaseFirestore.instance.collection('Users').snapshots();
    var documentStream = await FirebaseFirestore.instance.collection('Users').doc(uid).get();
    documentStream.data()!["email"];
    DocumentReference myDocRef =
        FirebaseFirestore.instance.collection("Users").doc(uid);

    var myDocs = await myDocRef.get();

    String? myName = documentStream.data()!["name"];

    DocumentReference reciverdocRef =
        _db!.collection(_userCollection!).doc(userID);
    var reciverdocSnap =await FirebaseFirestore.instance.collection('Users').doc(uid).get();

    String? reciverName = reciverdocSnap.data()!["name"];
    String? recMsg=myName!+"  تم استلام مبلغ من قبل "+"\n"+"\$ ${balance}"+" المبلغ المستلم "+"\n"+"  ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}"+ "بتارخ  " ;
    String? myMsg=reciverName!+"  تم ارسال مبلغ الى "+"\n"+"\$ ${balance}"+" المبلغ المحول "+"\n"+"  ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}"+ " بتاريخ  " ;

    reciverdocRef.update({
      "trans": FieldValue.arrayUnion([
        {
          "msg":

          recMsg,
          "note": note
        }
      ])
    });

    myDocRef.update({
      "trans": FieldValue.arrayUnion([
        {
          "msg":
          myMsg ,
          "note": note
        }
      ])
    });
    // final response = await Messaging.sendTo(title: "Money received", body: "Money received from ${myName} amount transferred:  \$ ${balance} At Time ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}", fcmToken: reciverdocSnap.data()!["token"]);
//

    // if (response.statusCode != 200) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     duration: Duration(seconds: 2),
    //     backgroundColor: Colors.green,
    //     content: Text(
    //       " sent succesfully",
    //       style: TextStyle(color: Colors.white, fontSize: 15),
    //     ),
    //   ));
    // }
  }

//#######################################################################################//
//#######################################################################################//

  Future<void> addCreditCard(
      {String? uid,
      String? creditNumber,
      String? creditDate,
      String? vcc,
      String? holderName}) async {
    print(creditNumber);
    DocumentReference docRef =
        FirebaseFirestore.instance.collection("Users").doc(uid);
    docRef.update({
      "credits": FieldValue.arrayUnion(
        [
          {
            "creditNumber": creditNumber,
            "creditDate": creditDate,
            "vcc": vcc,
            "holderName": holderName
          },
        ],
      ),
    });
  }

  Stream<PaymentModel> getUserData(String? _userID) {
    var _ref = _db!.collection(_userCollection!).doc(_userID);
    return _ref.get().asStream().map((_snapshot) {
      return PaymentModel.fromFirestore(_snapshot);
    });
  }
}
