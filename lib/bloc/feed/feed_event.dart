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
