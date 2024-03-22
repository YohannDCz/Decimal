part of 'feed_bloc.dart';

sealed class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object?> get props => [];
}

final class FetchInitial extends FeedState {}

final class FetchLoading extends FeedState {}

final class FetchPostsSuccess extends FeedState {
  const FetchPostsSuccess({required this.users, required this.publications, required this.publicationItem, required this.comments, required this.commentsUsers});

  final List<CustomUser> users;
  final List<PublicationModel> publications;
  final List<PublicationItemModel> publicationItem;
  final List<List<CommentModel>?> comments;
  final List<List<CustomUser>?> commentsUsers;

  @override
  List<Object?> get props => [users, publications, publicationItem, comments];
}
  
final class FetchPicsSuccess extends FeedState {
  const FetchPicsSuccess({required this.users, required this.publications, required this.publicationItem, required this.comments, required this.commentsUsers});

  final List<CustomUser> users;
  final List<PublicationModel> publications;
  final List<PublicationItemModel> publicationItem;
  final List<List<CommentModel>?> comments; 
  final List<List<CustomUser>?> commentsUsers;

  @override
  List<Object?> get props => [users, publications, publicationItem, comments];
}

final class FetchVideosSuccess extends FeedState {
  const FetchVideosSuccess({required this.users, required this.publications, required this.publicationItem, required this.comments, required this.commentsUsers});

  final List<CustomUser> users;
  final List<PublicationModel> publications;
  final List<PublicationItemModel> publicationItem;
  final List<List<CommentModel>?> comments;
  final List<List<CustomUser>?> commentsUsers;

  @override
  List<Object?> get props => [users, publications, publicationItem, comments];
}

final class FetchStoriesSuccess extends FeedState {
  const FetchStoriesSuccess({required this.users, required this.publications, required this.publicationItem, required this.comments, required this.commentsUsers});

  final List<CustomUser> users;
  final List<PublicationModel> publications;
  final List<PublicationItemModel> publicationItem;
  final List<List<CommentModel>?> comments;
  final List<List<CustomUser>?> commentsUsers;

  @override
  List<Object?> get props => [users, publications, publicationItem, comments];
}

final class FetchAllSuccess extends FeedState {
  const FetchAllSuccess({required this.fetchAllSuccess, required this.fetchStoriesSuccess});

  final Map<String, dynamic> fetchAllSuccess;
  final Map<String, dynamic> fetchStoriesSuccess;

  @override
  List<Object?> get props => [fetchAllSuccess, fetchStoriesSuccess];
}

final class FetchFailure extends FeedState {
  const FetchFailure({required this.error});

  final String error;

  @override
  List<Object> get props => [error];
}
