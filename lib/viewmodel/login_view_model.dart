import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:home_checklist/model/checklist_user.dart';
import 'package:home_checklist/repository/firebase_user_repository.dart';

class LoginViewModel extends ChangeNotifier{
  FirebaseUserRepository _repository = FirebaseUserRepository();
  bool _isLogin = false;
  ChecklistUser? _user;

  ChecklistUser? get user => _user;
  bool get isLogin => _isLogin;

  Future<void> login() async {
    GoogleSignInAccount? googleUser = await _repository.login();

    if (googleUser != null) {
      _user = ChecklistUser(
          googleUser.email,
          googleUser.photoUrl,
          googleUser.displayName,
      );
      _isLogin = true;

      notifyListeners();
    }
  }

  void logout() {
    _repository.logout();
    _isLogin = false;

    notifyListeners();
  }

}