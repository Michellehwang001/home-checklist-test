import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseUserRepository {
  //final _googleSignIn = GoogleSignIn();
  final GoogleSignIn _googleSignIn;

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  FirebaseUserRepository({GoogleSignIn? googleSignIn})
    : _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<GoogleSignInAccount?> login() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      return _user;

    } catch (e) {
      print(e.toString());
    }
  }

  Future logout() async {
    await _googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}