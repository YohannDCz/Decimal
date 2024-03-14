part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

final class SignInWithEmail extends AuthenticationEvent {
  SignInWithEmail({required this.user});
  final AppUser user;
}

final class SignUpWithEmail extends AuthenticationEvent {
  SignUpWithEmail({required this.user});
  final AppUser user;
}

final class SignOut extends AuthenticationEvent {}

final class GoogleLogin extends AuthenticationEvent {}

final class FacebookLogin extends AuthenticationEvent {}

final class TwitterLogin extends AuthenticationEvent {}

final class DeleteUser extends AuthenticationEvent {}