import 'package:bloc/bloc.dart';
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
        final publications = await feedService.getPublications("posts");
        final posts = await feedService.getPublicationItems("posts");
        final users = await feedService.getPublicationUsers("posts");
        emit(FetchPostsSuccess(users: users, publications: publications, publicationItem: posts));
      } catch (e) {
        emit(FetchFailure(error: e.toString()));
      }
    });
    on<FetchPics>((event, emit) async {
      emit(FetchLoading());

      try {
        final publications = await feedService.getPublications("pics");

        final pics = await feedService.getPublicationItems("pics");
        final users = await feedService.getPublicationUsers("pics");
        emit(FetchPicsSuccess(users: users, publications: publications, publicationItem: pics));
      } catch (e) {
        emit(FetchFailure(error: e.toString()));
      }
    });

    on<FetchVideos>((event, emit) async {
      emit(FetchLoading());

      try {
        final publications = await feedService.getPublications("videos");
        final videos = await feedService.getPublicationItems("videos");
        final users = await feedService.getPublicationUsers("videos");
        emit(FetchVideosSuccess(users: users, publications: publications, publicationItem: videos));
      } catch (e) {
        emit(FetchFailure(error: e.toString()));
      }
    });

    on<FetchStories>((event, emit) async {
      emit(FetchLoading());

      try {
        final publications = await feedService.getPublications("stories");
        final stories = await feedService.getPublicationItems("stories");
        final users = await feedService.getPublicationUsers("stories");
        emit(FetchStoriesSuccess(users: users, publications: publications, publicationItem: stories));
      } catch (e) {
        emit(FetchFailure(error: e.toString()));
      }
    });
  }

  FeedService feedService;
}
