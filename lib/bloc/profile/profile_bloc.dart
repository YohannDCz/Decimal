import 'package:bloc/bloc.dart';
import 'package:decimal/models/publication_items_model.dart';
import 'package:decimal/models/publication_model.dart';
import 'package:decimal/models/user_model.dart';
import 'package:decimal/service/profile_content_service.dart';
import 'package:decimal/service/profile_service.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.profileService, required this.profileContentService}) : super(ProfileInitial()) {
    on<FetchProfileContent>((event, emit) async {
      emit(FetchLoading());

      try {
        final fetchDescriptionSuccess = await profileContentService.getProfile(event.user_id);
        final fetchContactSuccess = await profileService.getContactsData(event.user_id);
        final fetchAllSuccess = await profileService.getPublicationsData(event.user_id);
        final fetchStoriesSuccess = await profileService.getStoriesData(event.user_id);
        final fetchPicsSuccess = await profileService.getPicsData(event.user_id);
        final fetchContactsNumberSuccess = await profileService.getContactsNumberData(event.user_id);

        emit(FetchProfileSuccess(
          fetchAllSuccess: fetchAllSuccess,
          fetchStoriesSuccess: fetchStoriesSuccess,
          fetchPicsSuccess: fetchPicsSuccess,
          fetchDescriptionSuccess: fetchDescriptionSuccess,
          fetchContactSuccess: fetchContactSuccess,
          fetchContactsNumberSuccess: fetchContactsNumberSuccess,
        ));
      } catch (e) {
        emit(FetchFailure(error: e.toString()));
      }
    });

    on<FetchProfileUserContent>((event, emit) async {
      emit(FetchLoading());

      try {
        final fetchDescriptionSuccess = await profileContentService.getProfile(event.user_id);
        final fetchContactSuccess = await profileService.getContactsData(event.user_id);
        final fetchAllSuccess = await profileService.getPublicationsData(event.user_id);
        final fetchStoriesSuccess = await profileService.getStoriesData(event.user_id);
        final fetchPicsSuccess = await profileService.getPicsData(event.user_id);
        final fetchContactsNumberSuccess = await profileService.getContactsNumberData(event.user_id);

        emit(FetchProfileUserSuccess(
          fetchAllSuccess: fetchAllSuccess,
          fetchStoriesSuccess: fetchStoriesSuccess,
          fetchPicsSuccess: fetchPicsSuccess,
          fetchDescriptionSuccess: fetchDescriptionSuccess,
          fetchContactSuccess: fetchContactSuccess,
          fetchContactsNumberSuccess: fetchContactsNumberSuccess,
        ));
      } catch (e) {
        emit(FetchFailure(error: e.toString()));
      }
    });

     on<GetProfile>((event, emit) async {
      emit(FetchLoading());

      try {
        final profile = await profileContentService.getProfile(event.user_uuid);

        emit(GetProfileSuccess(profile: profile));
      } catch (e) {
        emit(FetchFailure(error: e.toString()));
      }
    });

    on<PublishPublication>((event, emit) async {
      emit(PublishLoading());

      try {
        await profileService.publishPublication(event.publication, event.publicationItem);

        emit(PublishPublicationSuccess());
      } catch (e) {
        emit(FetchFailure(error: e.toString()));
      }
    });
  }

  ProfileService profileService;
  ProfileContentService profileContentService;
}
