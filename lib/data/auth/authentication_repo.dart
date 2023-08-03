

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shoper/data/auth/user.dart';

final authRepoProvider = Provider<AuthRepo>((ref) => AuthRepoImpl());

abstract class AuthRepo {
  Future<User?> login(String userName, String password);
}

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl();

  Future<User?> login(String userName, String password) async {
    await Future.delayed(Duration(seconds: 1));
    return User(id: "1", firstName: "Jay", lastName: "Tester");
    // return null;
  }
}