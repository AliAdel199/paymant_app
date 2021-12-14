
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:google_sign_in/google_sign_in.dart';

import './services/db_service.dart';

import 'package:firebase_auth/firebase_auth.dart';



class AuthenticationService {
  final FirebaseAuth? _firebaseAuth;
  User? user;

  // FirebaseMessaging messaging = FirebaseMessaging();
  GoogleSignIn _googleSignIn = GoogleSignIn(  scopes: [
    '169784826667-fd252el0rfd2ph8r19qqq2dnvrkei8rh.apps.googleusercontent.com',
  ],);

  /// This won't pop routes so you could do something like
  /// Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  /// after you called this method if you want to pop all routes.
  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth!.idTokenChanges();

  Future<void> signOut() async {
    await _firebaseAuth!.signOut();
  }

//  Future<String> signIn({String email, String password}) async {
//    try {
//
//
//    var result=  await _firebaseAuth.signInWithEmailAndPassword(
//          email: email, password: password);
//
//
//      DocumentReference docRef = FirebaseFirestore.instance
//          .collection("Users")
//          .doc(result.user.uid);
//      var token = await messaging.getToken();
//
//      docRef.update({"token": token.toString()});
//
//      return "Signed in";
//    } on FirebaseAuthException catch (e) {
//      return e.message;
//    }
//  }

  Future<String?> signInWithGoogle()async{

    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential).then((value)async{

        DocumentReference docRef=FirebaseFirestore.instance.collection("Users").doc(value.user!.uid);
        DocumentSnapshot docSnap=await docRef.get();
        if(docSnap.exists){
          await DBService.instance.updateUserNameAndImage(value.user!.uid,value.user!.displayName, value.user!.photoURL.toString());
        }else{
          await DBService.instance.createUserInDB(value.user!.uid, value.user!.displayName, value.user!.email, value.user!.photoURL.toString());
        }
      });
      return "Signed in";
    }catch (e) {
      e;
    }

//

  }

//  Future<String> signUp(
//      {String email, String name, String password, File image}) async {
//    try {
//
//      EasyLoading.show(status: 'loading...',maskType: EasyLoadingMaskType.black,);
//      UserCredential authResult = await _firebaseAuth
//          .createUserWithEmailAndPassword(email: email, password: password);
//      user = authResult.user;
////      var _result =
////          await CloudStorageService.instance.uploadUserImage(user.uid, image);
////      var _imageURL = await _result.ref.getDownloadURL();
////      await DBService.instance.createUserInDB(user.uid, name, email, _imageURL);
//      EasyLoading.showSuccess('Great Success!');
//
//
//
//      return "Signed up";
//    } on FirebaseAuthException catch (e) {
//      return e.message;
//    }
//  }
}
