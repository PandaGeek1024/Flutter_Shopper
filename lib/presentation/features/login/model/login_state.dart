import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = Initial;

  const factory LoginState.loading() = Loading;

  const factory LoginState.success() = Success;

  const factory LoginState.failed() = Failed;
}

@freezed
class UserInput with _$UserInput {
  const factory UserInput({String? userName, String? password}) = _UserInput;

  const UserInput._();

  bool get allFieldsInputted => (userName?.isNotEmpty ?? false) && (password?.isNotEmpty ?? false);
}
