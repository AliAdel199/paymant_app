
 
 import '../models/model.dart';

import '../pages/last_transfer_page.dart';
import '../pages/my_add_credit_card_page.dart';
import '../pages/my_credits_cards.dart';
import '../pages/scan_me_page.dart';
import '../pages/sent_money.dart';

import 'package:flutter/material.dart';
import '../models/configuration.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:provider/provider.dart';

import '../authentication_service.dart';
import 'add_cridet_card.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
 final FirebaseAuth _auth = FirebaseAuth.instance;
  double? _deviceHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: primaryGreen,
        padding: EdgeInsets.only(top: 50, bottom: 70, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
//                    Row(
//                      children: [
//                        CircleAvatar(
//                          radius: 25.0,
//
//                          backgroundImage: NetworkImage("${_userData.image}"),
//                          backgroundColor: Colors.transparent,
//                        ),
//                        SizedBox(
//                          width: 10,
//                        ),
//                        Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: [
//                            Text(
//                              '${_userData.name}',
//                              style: TextStyle(
//                                  color: Colors.black,
//                                  fontWeight: FontWeight.bold),
//                            ),
//                            Text('${_userData.email}',
//                                style: TextStyle(
//                                    color: Colors.black,
//                                    fontWeight: FontWeight.bold))
//                          ],
//                        )
//                      ],
//                    ),
            const  SizedBox(
              height: 100,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              drawerItems(
                Image.asset(
                  "images/tran.png",
                  width: 50,
                ),
                "أرسال اموال",
                () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SentMoneyPage()),
                ),
              ),
              const  SizedBox(
                height: 15,
              ),
              drawerItems(
                Image.asset(
                  "images/scan.png",
                  width: 50,
                ),
                "معلوماتي",
                () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>const ScanMePage()),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              drawerItems(
                Image.asset(
                  "images/card1.png",
                  width: 50,
                ),
                "بطاقاتي",
                () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>const MyCreditsPage()),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              drawerItems(
                Image.asset(
                  "images/note.png",
                  width: 50,
                ),
                "اخر الاشعارات",
                () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>const LastTransferPage()),
                ),
              ),
              const   SizedBox(
                height: 15,
              ),
              drawerItems(
                Image.asset(
                  "images/card.png",
                  width: 50,
                ),
                "اضافة بطاقة",
                () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MySample()),
                ),
              ),
              const SizedBox(
                height: 75,
              ),
            ]),
            Row(
              children: [
                drawerItems(
                  const  Icon(
                    Icons.logout,
                    color: Colors.red,
                    size: 30,
                  ),
                  "Log Out",
                  () => context.read<AuthenticationService>().signOut(),
                ),
              ],
            )
          ],
        ));
  }

  Widget drawerItems(Widget icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          icon,
          const SizedBox(
            width: 10,
          ),
          Text(title,
              style:const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20))
        ],
      ),
    );
  }
}
