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
      // emit(FetchLoading());

      try {
        final publications = await feedService.getPublications("posts");
        final posts = await feedService.getPublicationItems("posts");
        final users = await feedService.getPublicationUsers("posts");
        final comments = await feedService.getComments("posts");
        final commentsUsers = await feedService.getCommentUsers("posts");
        emit(FetchPostsSuccess(users: users, publications: publications, publicationItem: posts, comments: comments, commentsUsers: commentsUsers));
      } catch (e) {
        emit(FetchFailure(error: e.toString()));
      }
    });
    on<FetchPics>((event, emit) async {
      // emit(FetchLoading());

      try {
        final publications = await feedService.getPublications("pics");
        final pics = await feedService.getPublicationItems("pics");
        final users = await feedService.getPublicationUsers("pics");
        final comments = await feedService.getComments("pics");
        final commentsUsers = await feedService.getCommentUsers("pics");
        emit(FetchPicsSuccess(users: users, publications: publications, publicationItem: pics, comments: comments, commentsUsers: commentsUsers));
      } catch (e) {
        emit(FetchFailure(error: e.toString()));
      }
    });

    on<FetchVideos>((event, emit) async {
      // emit(FetchLoading());

      try {
        final publications = await feedService.getPublications("videos");
        final videos = await feedService.getPublicationItems("videos");
        final users = await feedService.getPublicationUsers("videos");
        final comments = await feedService.getComments("videos");
        final commentsUsers = await feedService.getCommentUsers("videos");
        emit(FetchVideosSuccess(users: users, publications: publications, publicationItem: videos, comments: comments, commentsUsers: commentsUsers));
      } catch (e) {
        emit(FetchFailure(error: e.toString()));
      }
    });

    on<FetchStories>((event, emit) async {
      // emit(FetchLoading());

      try {
        final publications = await feedService.getPublications("stories");
        final stories = await feedService.getPublicationItems("stories");
        final users = await feedService.getPublicationUsers("stories");
        final comments = await feedService.getComments("stories");
        final commentsUsers = await feedService.getCommentUsers("stories");
        emit(FetchStoriesSuccess(users: users, publications: publications, publicationItem: stories, comments: comments, commentsUsers: commentsUsers));
      } catch (e) {
        emit(FetchFailure(error: e.toString()));
      }
    });

    on<FetchAllPublications>((event, emit) async {
      // emit(FetchLoading());

      try {
        final fetchAllSuccess = await feedService.getPublicationData();
        final fetchStoriesSuccess = await feedService.getStoriesData();

        emit(FetchAllSuccess(fetchAllSuccess: fetchAllSuccess, fetchStoriesSuccess: fetchStoriesSuccess));
      } catch (e) {
        emit(FetchFailure(error: e.toString()));
      }
    });
  }

  FeedService feedService;
}
