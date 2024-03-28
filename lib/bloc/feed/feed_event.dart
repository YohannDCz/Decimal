// ignore_for_file: non_constant_identifier_names

part of 'feed_bloc.dart';

sealed class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object> get props => [];
}

final class FetchPosts extends FeedEvent {}

final class FetchPics extends FeedEvent {}

final class FetchVideos extends FeedEvent {}

final class FetchStories extends FeedEvent {
}

final class FetchUsers extends FeedEvent {}

final class FetchAllPublications extends FeedEvent {}

final class FollowUser extends FeedEvent {
  final String user_uuid;

  const FollowUser(this.user_uuid);

  @override
  List<Object> get props => [user_uuid];
}

final class UnfollowUser extends FeedEvent {
  final String user_uuid;

  const UnfollowUser(this.user_uuid);

  @override
  List<Object> get props => [user_uuid];
}