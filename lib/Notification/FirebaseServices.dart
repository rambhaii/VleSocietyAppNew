import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices
{
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  late UserCredential userCredential;

  Future<UserCredential> signInWithGooglewithFirebase()
  async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null)
      {

        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential authCredential =
        GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
           userCredential =  await _auth.signInWithCredential(authCredential);

         }
          } on FirebaseAuthException catch (e)
       {
      print(e.message);
      throw e;
    }
    return userCredential;
  }


   signInWithFacebook() async
  {

    try
    {
       print("djfkg");
      final LoginResult loginResult = await FacebookAuth.instance.login(permissions: ['email', 'public_profile', 'user_birthday']
    );

    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
    final userData = await FacebookAuth.instance.getUserData();

    String userEmail = userData['email'];
    print("djfkghjkdfg"+userEmail+"fdfgdgf"+FirebaseAuth.instance.signInWithCredential(facebookAuthCredential).toString());

       print("djfkg");
     } on
    FirebaseAuthException catch (e)
    {
      print("djfkg");
      print("sdfdf"+e.message.toString());
      throw e;
    }
    }

  googleSignOut() async
  {

    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}