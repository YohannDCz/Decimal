part of 'profile_content_bloc.dart';

sealed class ProfileContentState extends Equatable {
  const ProfileContentState({this.user});

  final CustomUser? user;

  @override
  List<Object?> get props => [user];
}

final class ProfileContentInitial extends ProfileContentState {}

final class ProfileContentLoading extends ProfileContentState {}

final class ProfileContentSuccess extends ProfileContentState {
  const ProfileContentSuccess(CustomUser? user) : super(user: user);

  @override
  List<Object?> get props => [user];
}

final class ProfileContentFailure extends ProfileContentState {
  const ProfileContentFailure({required this.error});

  final String error;

  @override
  List<Object> get props => [error];
}
