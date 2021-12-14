
import 'package:cloud_firestore/cloud_firestore.dart';


class PaymentModel {
  final String?id;
  final String?email;
  final String?image;
  final String?name;
   var balance;
  final List? trans;
  final List? credits;
  final String?token;



  PaymentModel({this.id, this.email, this.name, this.image,this.balance,this.trans,this.credits,this.token});

  factory PaymentModel.fromFirestore(var _snapshot) {
    var _data = _snapshot.data;
    return PaymentModel(
      id: _snapshot.id,
           email: _data()!["email"],
      name: _data()!["name"],
      image: _data()!["image"].toString(),
      balance: _data()!["balance"],
      trans: _data()!["trans"],
      credits: _data()!["credits"],
      token: _data()!["token"]

    );
  }
}
