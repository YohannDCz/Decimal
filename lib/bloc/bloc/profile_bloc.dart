import 'package:bloc/bloc.dart';
import 'package:decimal/models/user_model.dart';
import 'package:decimal/service/profile_content_service.dart';
import 'package:decimal/service/profile_service.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.profileService, required this.profileContentService}) : super(ProfileInitial()) {
    on<FetchAllPublications>((event, emit) async {
      emit(FetchLoading());

      try {
        final fetchDescriptionSuccess = await profileContentService.getProfile();
        final fetchContactSuccess = await profileService.getContactsData();
        final fetchAllSuccess = await profileService.getPublicationsData();
        final fetchStoriesSuccess = await profileService.getStoriesData();
        final fetchPicsSuccess = await profileService.getPicsData();

        emit(FetchAllSuccess(fetchAllSuccess: fetchAllSuccess, fetchStoriesSuccess: fetchStoriesSuccess, fetchPicsSuccess: fetchPicsSuccess, fetchDescriptionSuccess: fetchDescriptionSuccess, fetchContactSuccess: fetchContactSuccess));
      } catch (e) {
        emit(FetchFailure(error: e.toString()));
      }
    });
  }

  ProfileService profileService;
  ProfileContentService profileContentService;
}
