import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_checklist/repository/firebase_user_repository.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';

void main() {
  group('firebase user repository', () {
    test('firebase login, logout', () async {
      final user = MockUser(
        isAnonymous: false,
        uid: 'testid',
        email: 'test@test.com',
        displayName: 'tester',
      );

      final fakeFirebaseAuthRepository = FirebaseUserRepository(googleSignIn: MockGoogleSignIn());

      await fakeFirebaseAuthRepository.login();
      await fakeFirebaseAuthRepository.logout();
      await fakeFirebaseAuthRepository.login();
    });
  });
}