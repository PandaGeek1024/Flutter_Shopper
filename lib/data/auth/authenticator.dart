import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shoper/data/auth/authentication_repo.dart';
import 'package:flutter_shoper/data/auth/user.dart';

final authenticatorProvider = StateNotifierProvider((ref) {
  final authRepo = ref.watch(authRepoProvider);
  return Authenticator(authRepo);
});

class Authenticator extends StateNotifier<User?> {
  Authenticator(this._authRepo): super(null);
  final AuthRepo _authRepo;

  bool get loggedIn => state != null;

  Future<User?> login(String userName, String password) async {
    final user = await _authRepo.login(userName, password);
    state = user;
    return user;
  }
}