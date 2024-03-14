import 'package:bloc_test/bloc_test.dart';
import 'package:decimal/bloc/authentication/authentication_bloc.dart';
import 'package:decimal/models/user_model.dart';
import 'package:decimal/service/authentication_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {}

void main() {
  group('AuthenticationBloc', () {
    late AuthenticationBloc authenticationBloc;
    late MockAuthenticationService mockAuthenticationService;

    setUpAll(() {
      registerFallbackValue(AppUser(email: 'test@example.com', password: 'password'));
    });

    setUp(() {
      mockAuthenticationService = MockAuthenticationService();
      authenticationBloc = AuthenticationBloc(authenticationService: mockAuthenticationService);
    });

    tearDown(() {
      authenticationBloc.close();
    });

    test('initial state is AuthenticationInitial', () {
      expect(authenticationBloc.state, equals(AuthenticationInitial()));
    });

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationLoading, AuthenticationSuccess] when SignInWithEmail is added',
      build: () {
        when(() => mockAuthenticationService.signInWithEmail(any())).thenAnswer((_) async => {});
        return authenticationBloc;
      },
      act: (bloc) => bloc.add(SignInWithEmail(user: AppUser(email: 'test@example.com', password: 'password'))),
      expect: () => [AuthenticationLoading(), AuthenticationSuccess()],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationLoading, AuthenticationFailure] when SignInWithEmail fails',
      build: () {
        when(() => mockAuthenticationService.signInWithEmail(any())).thenThrow(Exception('Sign in failed'));
        return authenticationBloc;
      },
      act: (bloc) => bloc.add(SignInWithEmail(user: AppUser(email: 'test@example.com', password: 'password'))),
      expect: () => [AuthenticationLoading(), AuthenticationFailure(error: 'Exception: Sign in failed')],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationLoading, AuthenticationSuccess] when SignUpWithEmail is added',
      build: () {
        when(() => mockAuthenticationService.signUpWithEmail(any())).thenAnswer((_) async => {});
        return authenticationBloc;
      },
      act: (bloc) => bloc.add(SignUpWithEmail(user: AppUser(email: 'test@example.com', password: 'password'))),
      expect: () => [AuthenticationLoading(), AuthenticationSuccess()],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationLoading, AuthenticationFailure] when SignUpWithEmail fails',
      build: () {
        when(() => mockAuthenticationService.signUpWithEmail(any())).thenThrow(Exception('Sign up failed'));
        return authenticationBloc;
      },
      act: (bloc) => bloc.add(SignUpWithEmail(user: AppUser(email: 'test@example.com', password: 'password'))),
      expect: () => [AuthenticationLoading(), AuthenticationFailure(error: 'Exception: Sign up failed')],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationInitial] when SignOut is added',
      build: () {
        when(() => mockAuthenticationService.logOut()).thenAnswer((_) async => {});
        return authenticationBloc;
      },
      act: (bloc) => bloc.add(SignOut()),
      expect: () => [AuthenticationInitial()],
    );

    // Add more test cases for GoogleLogin, FacebookLogin, TwitterLogin, and DeleteUser events
  });
}
