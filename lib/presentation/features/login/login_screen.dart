import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login_controller.dart';
import 'login_screen_state.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

  final userNameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final userInput = ref.read(userInputProvider);
    userNameTextController.text = userInput.userName ?? '';
    passwordTextController.text = userInput.password ?? '';
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(userInputProvider);
    final status = ref.watch(loginStateProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: status.maybeWhen(loading: () {
          return const Center(child: CircularProgressIndicator());
        }, orElse: () {
          return Column(
            children: [
              TextField(
                controller: userNameTextController,
                decoration: const InputDecoration(hintText: 'Enter user name'),
                onChanged: (value) {
                  final userInput = ref.read(userInputProvider);
                  ref.read(userInputProvider.notifier).state = userInput.copyWith(userName: value);
                },
              ),
              TextField(
                controller: passwordTextController,
                decoration: const InputDecoration(hintText: 'Enter password'),
                onChanged: (value) {
                  final userInput = ref.read(userInputProvider);
                  ref.read(userInputProvider.notifier).state = userInput.copyWith(password: value);
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    ref.read(loginControllerProvider).login();
                  },
                  child: const Text('Login'))
            ],
          );
        }));
  }
}

