
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/auth/authenticator.dart';
import 'login_screen_state.dart';
import 'model/login_state.dart';

final loginControllerProvider = Provider.autoDispose<LoginController>((ref) {
  final stateController = ref.watch(loginStateProvider.notifier);
  return LoginController(ref, stateController);
});

class LoginController {
  LoginController(this._ref, this._stateController);
  final Ref _ref;
  final StateController _stateController;

  void login() async {
    _stateController.state = const LoginState.loading();
    final userInput = _ref.read(userInputProvider);
    final user = await _ref.read(authenticatorProvider.notifier).login(userInput.userName!, userInput.password!);
    if (user != null) {
      _stateController.state = const LoginState.success();
    } else {
      _stateController.state = const LoginState.failed();
    }
  }
}