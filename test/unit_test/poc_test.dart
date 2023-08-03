import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class Pair with EquatableMixin {
  final int parentValue; //depends on parentValueProvider
  final int childValue;

  Pair({required this.parentValue, required this.childValue});

  Pair copyWith({int? parentValue, int? childValue}) {
    return Pair(parentValue: parentValue ?? this.parentValue, childValue: childValue ?? this.childValue);
  }

  @override
  String toString() {
    return 'parent: $parentValue, child: $childValue';
  }

  @override
  List<Object?> get props => [parentValue, childValue];
}

class UserRepository {
  String getUserId() => '123';
}

final parentValueProvider = StateProvider<int>((ref) => 0);
final userRepositoryProvider = Provider<UserRepository>((ref) => UserRepository());

class PairNotifier extends StateNotifier<Pair> {
  // Use ref to avoid rebuild when parent provider changed.
  PairNotifier({this.ref}) : super(Pair(parentValue: ref?.read(parentValueProvider)??0, childValue: 0)) {
    // If part of the state has a dependency on top level provider
    ref?.listen<int>(parentValueProvider, (previous, next) {
      state = state.copyWith(parentValue: next);
    });
  }

  final Ref? ref;

  String increment() {
    final userRepo = ref?.read(userRepositoryProvider);

    final second = state.childValue + 1;
    state = state.copyWith(childValue: second);
    final id = userRepo?.getUserId();
    return "$id ${state.parentValue} ${state.childValue}";
  }

  void pairChanged(int? pre, int next) {}
}

final pairStateProvider = StateNotifierProvider<PairNotifier, Pair>((ref) {
  return PairNotifier(ref: ref);
});

class MockPairNotifier extends PairNotifier {

  set debugState(Pair value) {
    state = value;
  }
}

final testerProvider = Provider<Pair>((ref) {
  final pair = ref.watch(pairStateProvider);
  return pair;
});

class MockUserRepository extends Mock implements UserRepository {}

class FooExample {

  int calculate() {
    return myCalc();
  }

  int myCalc() {
    return 6 * 7;
  }
}

class MockFooExample extends Mock implements FooExample { }

// @GenerateMocks([MockCat, MockPairNotifier])
void main() {
  final mockUserRepository = MockUserRepository();
  test('Test PairNotifier business logic.', () async {
    final container =
        ProviderContainer(overrides: [userRepositoryProvider.overrideWithValue(mockUserRepository)]);
    container.readProviderElement(parentValueProvider).setState(5);
    when(mockUserRepository.getUserId()).thenAnswer((_) => 'userId');

    final displayString = container.read(pairStateProvider.notifier).increment();
    final resultState = container.read(pairStateProvider);
    expect(
      displayString,
      'userId 5 1',
    );
    expect(
      resultState,
      Pair(parentValue: 5, childValue: 1),
    );
  });


  test('Test StateNotifierProvider with mocked state to pass down.', () async {
    final mockCounter = MockPairNotifier();
    final pairData = Pair(parentValue: 2, childValue: 3);
    mockCounter.debugState = pairData;

    final container = ProviderContainer(
      overrides: [pairStateProvider.overrideWithProvider(StateNotifierProvider<PairNotifier, Pair>((ref) {
        return mockCounter;
      }))],
    );
    container.pump();
    final resultState = container.read(pairStateProvider);
    expect(
      resultState,
      pairData,
    );
    final testerPair = container.read(testerProvider);
    expect(
      testerPair,
      pairData,
    );
    final testPair = Pair(parentValue: 5, childValue: 5);
    mockCounter.debugState = testPair;
    container.pump();
    final testerResult = container.read(pairStateProvider);
    expect(
      testerResult,
      testPair,
    );
    final testerPair1 = container.read(testerProvider);
    expect(
      testerPair1,
      testPair,
    );
  });

  test('Tester.', () async {
    final mock = MockCat();
    when(mock.hello()).thenReturn("My");
    expect(
      'My',
      mock.hello(),
    );
  });
}


class Cat {
  String hello() {
    return '';
  }
}

class MockCat extends Mock implements Cat {}