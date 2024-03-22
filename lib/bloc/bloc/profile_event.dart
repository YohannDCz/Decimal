part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class FetchPics extends ProfileEvent {}

final class FetchStories extends ProfileEvent {}

final class FetchAllPublications extends ProfileEvent {}

