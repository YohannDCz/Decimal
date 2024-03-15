import 'package:bloc/bloc.dart';
import 'package:decimal/models/user_model.dart';
import 'package:decimal/service/profile_content_serrvice.dart';
import 'package:equatable/equatable.dart';

part 'profile_content_event.dart';
part 'profile_content_state.dart';

class ProfileContentBloc extends Bloc<ProfileContentEvent, ProfileContentState> {
  ProfileContentBloc({required this.profileContentService}) : super(ProfileContentInitial()) {
    on<GetProfile>((event, emit) async {
      emit(ProfileContentLoading());

      try {
        final user = await profileContentService.getProfile();
        emit(ProfileContentSuccess(user));
      } catch (e) {
        emit(ProfileContentFailure(error: e.toString()));
      }
    });
    on<UpdateProfile>((event, emit) async {
      emit(ProfileContentLoading());

      try {
        await profileContentService.updateProfile(event.user);
        emit(ProfileContentSuccess(event.user));
      } catch (e) {
        emit(ProfileContentFailure(error: e.toString()));
      }
    });

    on<DeleteProfile>((event, emit) async {
      emit(ProfileContentLoading());

      try {
        await profileContentService.deleteProfile();
        emit(const ProfileContentSuccess(null));
      } catch (e) {
        emit(ProfileContentFailure(error: e.toString()));
      }
    });

    on<UploadProfilePicture>((event, emit) async {
      emit(ProfileContentLoading());

      try {
        final imageUrl = await profileContentService.uploadPicture();
        final updatedUser = state.user!.copyWith(profile_picture: imageUrl);
        emit(ProfileContentSuccess(updatedUser));
      } catch (e) {
        emit(ProfileContentFailure(error: e.toString()));
      }
    });

    on<UploadCoverPicture>((event, emit) async {
      emit(ProfileContentLoading());

      try {
        final imageUrl = await profileContentService.uploadPicture();
        final updatedUser = state.user!.copyWith(cover_picture: imageUrl);
        emit(ProfileContentSuccess(updatedUser));
      } catch (e) {
        emit(ProfileContentFailure(error: e.toString()));
      }
    });
  }
  ProfileContentService profileContentService;
}
