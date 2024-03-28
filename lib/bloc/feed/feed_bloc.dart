import 'package:bloc/bloc.dart';
import 'package:decimal/models/comment_model.dart';
import 'package:decimal/models/publication_items_model.dart';
import 'package:decimal/models/publication_model.dart';
import 'package:decimal/models/user_model.dart';
import 'package:decimal/service/feed_service.dart';
import 'package:equatable/equatable.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc({required this.feedService}) : super(FetchInitial()) {
    on<FetchPosts>((event, emit) async {
      emit(FetchLoading());

      try {
        final publications = await feedService.getPublications("posts", 4);
        final posts = await feedService.getPublicationItems("posts", 4);
        final users = await feedService.getPublicationUsers("posts", 4);
        final comments = await feedService.getComments("posts", 4);
        final commentsUsers = await feedService.getCommentUsers("posts", 4);
        emit(FetchPostsSuccess(users: users, publications: publications, publicationItem: posts, comments: comments, commentsUsers: commentsUsers));
      } catch (e) {
        emit(FetchFailure(error: e.toString()));
      }
    });
    on<FetchPics>((event, emit) async {
      emit(FetchLoading());

      try {
        final publications = await feedService.getPublications("pics", 18);
        final pics = await feedService.getPublicationItems("pics", 18);
        final users = await feedService.getPublicationUsers("pics", 18);
        final comments = await feedService.getComments("pics", 18);
        final commentsUsers = await feedService.getCommentUsers("pics", 18);
        emit(FetchPicsSuccess(users: users, publications: publications, publicationItem: pics, comments: comments, commentsUsers: commentsUsers));
      } catch (e) {
        emit(FetchFailure(error: e.toString()));
      }
    });

    on<FetchVideos>((event, emit) async {
      emit(FetchLoading());

      try {
        final publications = await feedService.getPublications("videos", 3);
        final videos = await feedService.getPublicationItems("videos", 3);
        final users = await feedService.getPublicationUsers("videos", 3);
        final comments = await feedService.getComments("videos", 3);
        final commentsUsers = await feedService.getCommentUsers("videos", 3);
        emit(FetchVideosSuccess(users: users, publications: publications, publicationItem: videos, comments: comments, commentsUsers: commentsUsers));
      } catch (e) {
        emit(FetchFailure(error: e.toString()));
      }
    });

    on<FetchStories>((event, emit) async {
      emit(FetchLoading());

      try {
        final publications = await feedService.getPublications("stories", 6);
        final stories = await feedService.getPublicationItems("stories", 6);
        final users = await feedService.getPublicationUsers("stories", 6);
        final comments = await feedService.getComments("stories", 6);
        final commentsUsers = await feedService.getCommentUsers("stories", 6);
        emit(FetchStoriesSuccess(users: users, publications: publications, publicationItem: stories, comments: comments, commentsUsers: commentsUsers));
      } catch (e) {
        emit(FetchFailure(error: e.toString()));
      }
    });

    on<FetchAllPublications>((event, emit) async {
      emit(FetchLoading());

      try {
        final fetchAllSuccess = await feedService.getPublicationData();
        final fetchStoriesSuccess = await feedService.getStoriesData();

        emit(FetchAllSuccess(fetchAllSuccess: fetchAllSuccess, fetchStoriesSuccess: fetchStoriesSuccess));
      } catch (e) {
        emit(FetchFailure(error: e.toString()));
      }
    });

    on<FollowUser>((event, emit) async {
      emit(FollowLoading());

      try {
        await feedService.followUser(event.user_uuid);
        emit(FollowSuccess());
      } catch (e) {
        emit(FetchFailure(error: e.toString()));
      }
    });

    on<UnfollowUser>((event, emit) async {
      emit(FollowLoading());

      try {
        await feedService.unfollowUser(event.user_uuid);
        emit(UnFollowSuccess());
      } catch (e) {
        emit(FetchFailure(error: e.toString()));
      }
    });
  }

  FeedService feedService;
}
