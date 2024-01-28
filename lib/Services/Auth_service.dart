import 'package:location/Global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Google Sign in
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser == null) {
        return null;
      }
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      final creds = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      final authUser = await firebaseAuth.signInWithCredential(creds);
      return authUser.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  getProfileImage() async {
    if (firebaseAuth.currentUser!.photoURL != null) {
      String profilePhotoUrl = firebaseAuth.currentUser!.photoURL ?? "";
      return profilePhotoUrl;
    } else {
      return "";
    }
  }
}
