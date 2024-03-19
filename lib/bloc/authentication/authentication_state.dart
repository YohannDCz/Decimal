part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

final class AuthenticationLoading extends AuthenticationState {}

final class AuthenticationSuccess extends AuthenticationState {
  AuthenticationSuccess({this.userExist});
  final bool? userExist;
}

final class AuthenticationFailure extends AuthenticationState {
  AuthenticationFailure({required this.error});
  final String error;
}
