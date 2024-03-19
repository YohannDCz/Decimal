part of 'feed_bloc.dart';

sealed class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object?> get props => [];
}

final class FetchInitial extends FeedState {}

final class FetchLoading extends FeedState {}

final class FetchPostsSuccess extends FeedState {
  const FetchPostsSuccess({required this.users, required this.publications, required this.publicationItem});

  final List<CustomUser> users;
  final List<PublicationModel> publications;
  final List<PublicationItemModel> publicationItem;

  @override
  List<Object> get props => [users, publications, publicationItem];
}
  

final class FetchPicsSuccess extends FeedState {
  const FetchPicsSuccess({required this.publications, required this.users, required this.publicationItem});

  final List<PublicationModel> publications;
  final List<CustomUser> users;
  final List<PublicationItemModel> publicationItem;

  @override
  List<Object> get props => [publications, users, publicationItem];
}

final class FetchVideosSuccess extends FeedState {
  const FetchVideosSuccess({required this.publications, required this.users, required this.publicationItem});

  final List<PublicationModel> publications;
  final List<CustomUser> users;
  final List<PublicationItemModel> publicationItem;

  @override
  List<Object> get props => [publications, users,   publicationItem];
}

final class FetchStoriesSuccess extends FeedState {
  const FetchStoriesSuccess({required this.publications, required this.users, required this.publicationItem});

  final List<PublicationModel> publications;
  final List<CustomUser> users;
  final List<PublicationItemModel> publicationItem;

  @override
  List<Object> get props => [publications, users, publicationItem];
}

final class FetchFailure extends FeedState {
  const FetchFailure({required this.error});

  final String error;

  @override
  List<Object> get props => [error];
}
