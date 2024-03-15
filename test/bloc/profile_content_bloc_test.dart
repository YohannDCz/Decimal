import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:decimal/bloc/profile_content/profile_content_bloc.dart';
import 'package:decimal/models/user_model.dart';
import 'package:decimal/service/profile_content_serrvice.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockProfileContentService extends Mock implements ProfileContentService {}

void main() {
  group('ProfileContentBloc', () {
    late ProfileContentBloc profileContentBloc;
    late MockProfileContentService mockProfileContentService;
    late CustomUser user;

    setUpAll(() {
      registerFallbackValue(File('path/to/image'));
      registerFallbackValue(CustomUser(id: '', profile_picture: '', cover_picture: '', name: '', pseudo: ''));
    });

    setUp(() {
      mockProfileContentService = MockProfileContentService();
      profileContentBloc = ProfileContentBloc(profileContentService: mockProfileContentService);
      user = CustomUser(id: '', profile_picture: '', cover_picture: '', name: '', pseudo: '');
    });

    tearDown(() {
      profileContentBloc.close();
    });

    test('initial state is ProfileContentInitial', () {
      expect(profileContentBloc.state, equals(ProfileContentInitial()));
    });

    blocTest<ProfileContentBloc, ProfileContentState>(
      'emits [ProfileContentLoading, ProfileContentSuccess] when UploadProfilePicture is added',
      build: () {
        when(() => mockProfileContentService.uploadPicture()).thenAnswer((_) async => 'path/to/image');
        return profileContentBloc;
      },
      act: (bloc) => bloc.add(UploadProfilePicture()),
      expect: () => [ProfileContentLoading(), const ProfileContentSuccess(profilePictureUrl: 'path/to/image')],
    );

    blocTest<ProfileContentBloc, ProfileContentState>(
      'emits [ProfileContentLoading, ProfileContentFailure] when UploadProfilePicture fails',
      build: () {
        when(() => mockProfileContentService.uploadPicture()).thenThrow(Exception('Profile loading failed'));
        return profileContentBloc;
      },
      act: (bloc) => bloc.add(UploadProfilePicture()),
      expect: () => [ProfileContentLoading(), const ProfileContentFailure(error: 'Exception: Profile loading failed')],
    );

    blocTest<ProfileContentBloc, ProfileContentState>(
      'emits [ProfileContentLoading, ProfileContentSuccess] when UploadCoverPicture is added',
      build: () {
        when(() => mockProfileContentService.uploadPicture()).thenAnswer((_) async => 'path/to/image');
        return profileContentBloc;
      },
      act: (bloc) => bloc.add(UploadCoverPicture()),
      expect: () => [ProfileContentLoading(), const ProfileContentSuccess(coverPictureUrl: 'path/to/image')],
    );

    blocTest<ProfileContentBloc, ProfileContentState>(
      'emits [ProfileContentLoading, ProfileContentFailure] when UploadCoverPicture fails',
      build: () {
        when(() => mockProfileContentService.uploadPicture()).thenThrow(Exception('Profile loading failed'));
        return profileContentBloc;
      },
      act: (bloc) => bloc.add(UploadCoverPicture()),
      expect: () => [ProfileContentLoading(), const ProfileContentFailure(error: 'Exception: Profile loading failed')],
    );

    blocTest<ProfileContentBloc, ProfileContentState>(
      'emits [ProfileContentLoading, ProfileContentSuccess] when GetProfile is added',
      build: () {
        when(() => mockProfileContentService.getProfile()).thenAnswer((_) async => user);
        return profileContentBloc;
      },
      act: (bloc) => bloc.add(GetProfile()),
      expect: () => [ProfileContentLoading(), ProfileContentSuccess(user: user)],
    );

    blocTest<ProfileContentBloc, ProfileContentState>(
      'emits [ProfileContentLoading, ProfileContentFailure] when GetProfile fails',
      build: () {
        when(() => mockProfileContentService.getProfile()).thenThrow(Exception('Profile loading failed'));
        return profileContentBloc;
      },
      act: (bloc) => bloc.add(GetProfile()),
      expect: () => [ProfileContentLoading(), const ProfileContentFailure(error: 'Exception: Profile loading failed')],
    );

    blocTest<ProfileContentBloc, ProfileContentState>(
      'emits [ProfileContentLoading, ProfileContentSuccess] when UpdateProfile is added',
      build: () {
        when(() => mockProfileContentService.updateProfile(any())).thenAnswer((_) async {});
        return profileContentBloc;
      },
      act: (bloc) => bloc.add(UpdateProfile(user)),
      expect: () => [ProfileContentLoading(), ProfileContentSuccess(user: user)],
    );

    blocTest<ProfileContentBloc, ProfileContentState>(
      'emits [ProfileContentLoading, ProfileContentFailure] when UpdateProfile fails',
      build: () {
        when(() => mockProfileContentService.updateProfile(any())).thenThrow(Exception('Profile loading failed'));
        return profileContentBloc;
      },
      act: (bloc) => bloc.add(UpdateProfile(user)),
      expect: () => [ProfileContentLoading(), const ProfileContentFailure(error: 'Exception: Profile loading failed')],
    );

    blocTest<ProfileContentBloc, ProfileContentState>(
      'emits [ProfileContentLoading, ProfileContentSuccess] when DeleteProfile is added',
      build: () {
        when(() => mockProfileContentService.deleteProfile()).thenAnswer((_) async => {});
        return profileContentBloc;
      },
      act: (bloc) => bloc.add(DeleteProfile()),
      expect: () => [ProfileContentLoading(), const ProfileContentSuccess()],
    );

    blocTest<ProfileContentBloc, ProfileContentState>(
      'emits [ProfileContentLoading, ProfileContentFailure] when DeleteProfile fails',
      build: () {
        when(() => mockProfileContentService.deleteProfile()).thenThrow(Exception('Profile loading failed'));
        return profileContentBloc;
      },
      act: (bloc) => bloc.add(DeleteProfile()),
      expect: () => [ProfileContentLoading(), const ProfileContentFailure(error: 'Exception: Profile loading failed')],
    );
  });
}
