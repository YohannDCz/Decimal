part of 'profile_content_bloc.dart';

sealed class ProfileContentEvent extends Equatable {
  const ProfileContentEvent();

  @override
  List<Object> get props => [];
}

final class GetProfile extends ProfileContentEvent {}

final class UpdateProfile extends ProfileContentEvent {
  const UpdateProfile(this.user);

  final CustomUser user;

  @override
  List<Object> get props => [user];
}

final class DeleteProfile extends ProfileContentEvent {}

final class UploadProfilePicture extends ProfileContentEvent {}

final class UploadCoverPicture extends ProfileContentEvent {}

final class UpdateName extends ProfileContentEvent {
  const UpdateName(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class UpdatePseudo extends ProfileContentEvent {
  const UpdatePseudo(this.pseudo);

  final String pseudo;

  @override
  List<Object> get props => [pseudo];
}

final class GetContacts extends ProfileContentEvent {}

final class GetFollowers extends ProfileContentEvent {}

final class GetFollowings extends ProfileContentEvent {}