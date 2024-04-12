// ignore_for_file: non_constant_identifier_names

part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class FetchPics extends ProfileEvent {}

final class FetchStories extends ProfileEvent {}

final class FetchProfileContent extends ProfileEvent {
  final String user_id;

  const FetchProfileContent(this.user_id);

  @override
  List<Object> get props => [user_id];
}

final class FetchProfileUserContent extends ProfileEvent {
  final String user_id;

  const FetchProfileUserContent(this.user_id);

  @override
  List<Object> get props => [user_id];
}

final class GetProfile extends ProfileEvent {
  final String user_uuid;

  const GetProfile(this.user_uuid);

  @override
  List<Object> get props => [user_uuid];
}

final class PublishPublication extends ProfileEvent {
  final PublicationModel publication;
  final PublicationItemModel publicationItem;

  const PublishPublication(this.publication, this.publicationItem);

  @override
  List<Object> get props => [publication, publicationItem];
}

final class UploadPic extends ProfileEvent {}
