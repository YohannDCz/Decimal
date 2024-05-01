import 'package:decimal/models/user_model.dart';
import 'package:decimal/service/authentication_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

class MockUser extends Mock implements User {}

class MockPostgrestResponse extends Mock implements PostgrestResponse {}

class MockSupabaseQueryBuilder extends Mock implements SupabaseQueryBuilder {}

class MockPostgrestFilterBuilder extends Mock implements PostgrestFilterBuilder {}

void main() {
  late MockSupabaseClient mockSupabaseClient;
  late MockGoTrueClient mockGoTrueClient;
  late MockUser mockUser;
  late AuthenticationService authService;
  late MockSupabaseQueryBuilder mockQueryBuilder;
  late MockPostgrestFilterBuilder mockFilterBuilder;

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    mockGoTrueClient = MockGoTrueClient();
    mockUser = MockUser();
    mockQueryBuilder = MockSupabaseQueryBuilder();
    mockFilterBuilder = MockPostgrestFilterBuilder();
    authService = AuthenticationService(supabaseClient: mockSupabaseClient);

    when(mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
    when(mockGoTrueClient.currentUser).thenReturn(mockUser);
    when(mockUser.id).thenReturn('user-id');
    when(mockUser.email).thenReturn('test@example.com');

    // Setting up the mocks for Supabase Query Builder
    when(mockSupabaseClient.from(any)).thenReturn(mockQueryBuilder);
    when(mockQueryBuilder.upsert(any)).thenReturn(mockFilterBuilder); // Correcting the return type here
    when(mockFilterBuilder).thenReturn(mockFilterBuilder); // This is where execute is called
  });

  test('SignIn with email should complete successfully', () async {
    when(mockGoTrueClient.signInWithPassword(email: anyNamed('email'), password: 'password')).thenAnswer((_) async => AuthResponse());
    expect(await authService.signInWithEmail(AppUser(email: 'test@example.com', password: 'password123')), isA<void>());
  });

  test('SignUp with email should return success message', () async {
    when(mockGoTrueClient.signUp(email: anyNamed('email'), password: 'password')).thenAnswer((_) async => AuthResponse());
    expect(await authService.signUpWithEmail(AppUser(email: 'test@example.com', password: 'password123')), equals('User signed up successfully'));
  });

  test('LogOut should complete successfully', () async {
    when(mockGoTrueClient.signOut()).thenAnswer((_) async => {});
    await authService.logOut();
    verify(mockGoTrueClient.signOut()).called(1);
  });
  test('Create table entry should complete successfully', () async {
    expect(await authService.createTableEntry(), isA<PostgrestResponse>());
  });

  test('SignIn with Google should complete successfully', () async {
    when(mockGoTrueClient.signInWithOAuth(OAuthProvider.google)).thenAnswer((_) async => true);
    await authService.signInWithFacebook();
    verify(mockGoTrueClient.signInWithOAuth(OAuthProvider.google)).called(1);
  });

  test('SignIn with Facebook should complete successfully', () async {
    when(mockGoTrueClient.signInWithOAuth(OAuthProvider.facebook)).thenAnswer((_) async => true);
    await authService.signInWithFacebook();
    verify(mockGoTrueClient.signInWithOAuth(OAuthProvider.facebook)).called(1);
  });

  test('SignIn with Twitter should complete successfully', () async {
    when(mockGoTrueClient.signInWithOAuth(OAuthProvider.twitter)).thenAnswer((_) async => {});
    await authService.signInWithTwitter();
    verify(mockGoTrueClient.signInWithOAuth(OAuthProvider.twitter)).called(1);
  });

  test('Get user should return true if user exists', () async {
    when(mockSupabaseClient.from(any).select(any).eq(any, any).single()).thenAnswer((_) async => {});
    expect(await authService.getUser(), isTrue);
  });

  test('Delete user should complete successfully', () async {
    when(mockSupabaseClient.rpc(any, params: anyNamed('params'))).thenAnswer((_) async => {});
    await authService.deleteUser();
    verify(mockSupabaseClient.rpc(any, params: anyNamed('params'))).called(1);
  });

  // Add more detailed tests if necessary for edge cases and error handling
}
