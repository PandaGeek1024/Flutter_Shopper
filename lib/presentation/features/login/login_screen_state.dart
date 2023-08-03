import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shoper/data/auth/authenticator.dart';

import 'model/login_state.dart';

final hasLoginProvider = Provider((ref) {
  final user = ref.watch(authenticatorProvider);
  return user != null;
});

final userInputProvider = StateProvider.autoDispose((ref) {
  ref.onDispose(() {
    print('dispose');
  });
  return const UserInput();
});

final loginButtonEnabledProvider = Provider.autoDispose<bool>((ref) => ref.watch(userInputProvider).allFieldsInputted);

final loginStateProvider = StateProvider.autoDispose<LoginState>((ref) => const LoginState.initial());