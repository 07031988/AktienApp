import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
// isLogin => HomePage if not than signIn
  Stream<String> get onAuthStatechanged => _firebaseAuth.onAuthStateChanged.map(
        (FirebaseUser user) => user?.uid,
      );

//Email & Password SignUP
  Future<String> createUserWithEmailAndPassword(
      String email, String password, String firstname, String lastname) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    //Update the lastname && firstname

    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = firstname + " " + lastname;
    await currentUser.user.updateProfile(userUpdateInfo);
    await currentUser.user.reload();

    return currentUser.user.uid;
  }

//Email & Password SignIn

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user
        .uid;
  }

//Logout
  signOut() {
    return _firebaseAuth.signOut();
  }
}
