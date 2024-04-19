
import 'package:bloc_test/bloc_test.dart';
import 'package:decimal/bloc/feed/feed_bloc.dart';
import 'package:decimal/models/publication_items_model.dart';
import 'package:decimal/service/feed_service%201.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockFeedBloc extends MockBloc<FeedEvent, FeedState> implements FeedBloc {}

class MockFeedService extends Mock implements FeedService {}

class MockImagePicker extends Mock implements ImagePicker {}

void main() {
  group('FeedBloc', () {
    late FeedBloc feedBloc;
    late MockFeedService mockFeedService;
    late MockFeedBloc mockFeedBloc;
    late PublicationItemModel publicationItemModel;
    setUpAll(() {});

    setUp(() {
      mockFeedService = MockFeedService();
      feedBloc = FeedBloc(feedService: mockFeedService);
      mockFeedBloc = MockFeedBloc();
      publicationItemModel = const PublicationItemModel(id: 0, publication_id: '', url: '');
    });

    tearDown(() {
      feedBloc.close();
    });

    test('initial state is FetchInitial', () {
      expect(feedBloc.state, equals(FetchInitial()));
    });

    blocTest<FeedBloc, FeedState>(
      'emits [FetchLoading, FetchSuccess] when FetchPosts is added',
      build: () {
        when(() => mockFeedService.getPublicationItems("posts")).thenAnswer((_) async => [publicationItemModel]);

        return feedBloc;
      },
      act: (bloc) => bloc.add(FetchPosts()),
      expect: () => [
        FetchLoading(),
        FetchSuccess([publicationItemModel])
      ],
    );

    blocTest<FeedBloc, FeedState>(
      'emits [FetchLoading, FetchFailure] when FetchPosts fails',
      build: () {
        when(() => mockFeedService.getPublicationItems("posts")).thenThrow(Exception('Profile loading failed'));
        return feedBloc;
      },
      act: (bloc) => bloc.add(FetchPosts()),
      expect: () => [FetchLoading(), const FetchFailure(error: 'Exception: Profile loading failed')],
    );

     blocTest<FeedBloc, FeedState>(
      'emits [FetchLoading, FetchSuccess] when FetchPics is added',
      build: () {
        when(() => mockFeedService.getPublicationItems("pics")).thenAnswer((_) async => [publicationItemModel]);

        return feedBloc;
      },
      act: (bloc) => bloc.add(FetchPics()),
      expect: () => [
        FetchLoading(),
        FetchSuccess([publicationItemModel])
      ],
    );

    blocTest<FeedBloc, FeedState>(
      'emits [FetchLoading, FetchFailure] when FetchPics fails',
      build: () {
        when(() => mockFeedService.getPublicationItems("pics")).thenThrow(Exception('Profile loading failed'));
        return feedBloc;
      },
      act: (bloc) => bloc.add(FetchPics()),
      expect: () => [FetchLoading(), const FetchFailure(error: 'Exception: Profile loading failed')],
    );

     blocTest<FeedBloc, FeedState>(
      'emits [FetchLoading, FetchSuccess] when FetchVideos is added',
      build: () {
        when(() => mockFeedService.getPublicationItems("videos")).thenAnswer((_) async => [publicationItemModel]);

        return feedBloc;
      },
      act: (bloc) => bloc.add(FetchVideos()),
      expect: () => [
        FetchLoading(),
        FetchSuccess([publicationItemModel])
      ],
    );

    blocTest<FeedBloc, FeedState>(
      'emits [FetchLoading, FetchFailure] when FetchVideos fails',
      build: () {
        when(() => mockFeedService.getPublicationItems("videos")).thenThrow(Exception('Profile loading failed'));
        return feedBloc;
      },
      act: (bloc) => bloc.add(FetchVideos()),
      expect: () => [FetchLoading(), const FetchFailure(error: 'Exception: Profile loading failed')],
    );

     blocTest<FeedBloc, FeedState>(
      'emits [FetchLoading, FetchSuccess] when FetchStories is added',
      build: () {
        when(() => mockFeedService.getPublicationItems("stories")).thenAnswer((_) async => [publicationItemModel]);

        return feedBloc;
      },
      act: (bloc) => bloc.add(FetchStories()),
      expect: () => [
        FetchLoading(),
        FetchSuccess([publicationItemModel])
      ],
    );

    blocTest<FeedBloc, FeedState>(
      'emits [FetchLoading, FetchFailure] when FetchStories fails',
      build: () {
        when(() => mockFeedService.getPublicationItems("stories")).thenThrow(Exception('Profile loading failed'));
        return feedBloc;
      },
      act: (bloc) => bloc.add(FetchStories()),
      expect: () => [FetchLoading(), const FetchFailure(error: 'Exception: Profile loading failed')],
    );
  });
}
