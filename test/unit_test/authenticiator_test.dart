import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shoper/data/auth/authentication_repo.dart';
import 'package:flutter_shoper/data/auth/authenticator.dart';
import 'package:flutter_shoper/data/auth/user.dart';
import 'package:flutter_shoper/presentation/features/login/login_screen_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<AuthRepo>()])
import 'authenticiator_test.mocks.dart';

class MockAuthenticator extends Authenticator {
  MockAuthenticator(super.authRepo);

  set debugState(User? value) {
    state = value;
  }
}

void main() {
  test('Test MockAuthenticator business logic.', () async {
    final mockAuthRepo = MockAuthRepo();
    final mockAuthenticator = MockAuthenticator(mockAuthRepo);
    final container = ProviderContainer(overrides: [
      authenticatorProvider.overrideWithProvider(StateNotifierProvider((ref) => mockAuthenticator))
    ]);
    final user = container.read(authenticatorProvider);
    expect(
      user,
      null,
    );
    final hasLogin = container.read(hasLoginProvider);
    expect(
      hasLogin,
      false,
    );
    final mockUser1 = User(id: 'test1', firstName: "firstName", lastName: 'lastName');
    mockAuthenticator.debugState = mockUser1;
    container.pump();
    final user1 = container.read(authenticatorProvider);
    expect(
      user1,
      mockUser1,
    );
    final hasLogin1 = container.read(hasLoginProvider);
    expect(
      hasLogin1,
      true,
    );
  });
}
