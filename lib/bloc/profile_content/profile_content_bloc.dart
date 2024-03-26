import 'package:bloc/bloc.dart';
import 'package:decimal/config/constants.dart';
import 'package:decimal/models/user_model.dart';
import 'package:decimal/service/profile_content_service.dart';
import 'package:equatable/equatable.dart';

part 'profile_content_event.dart';
part 'profile_content_state.dart';

class ProfileContentBloc extends Bloc<ProfileContentEvent, ProfileContentState> {
  ProfileContentBloc({required this.profileContentService}) : super(ProfileContentInitial()) {
    on<GetProfile>((event, emit) async {
      emit(ProfileContentLoading());

      try {
        final user = await profileContentService.getProfile(supabaseUser!.id);
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
      } catch (e) {
        emit(ProfileContentFailure(error: e.toString()));
      }
    });

    on<UploadProfilePicture>((event, emit) async {
      emit(ProfileContentLoading());
      try {
        final image = await profileContentService.selectImage();
        if (image != null) {
          final imageUrl = await profileContentService.uploadPicture("profile", image);
          
          if (state.user == null) {
            final user = await profileContentService.getProfile(supabaseUser!.id);
            final updatedUser = user.copyWith(profile_picture: imageUrl);
            add(UpdateProfile(updatedUser));
          } else {
            final updatedUser = state.user!.copyWith(profile_picture: imageUrl);
            add(UpdateProfile(updatedUser));
          }
        }
      } catch (e) {
        emit(ProfileContentFailure(error: e.toString()));
      }
    });

    on<UploadCoverPicture>((event, emit) async {
      emit(ProfileContentLoading());
      try {
        final image = await profileContentService.selectImage();
        if (image != null) {
          final imageUrl = await profileContentService.uploadPicture("cover", image);

          if (state.user == null) {
            final user = await profileContentService.getProfile(supabaseUser!.id);
            final updatedUser = user.copyWith(cover_picture: imageUrl);
            add(UpdateProfile(updatedUser));
          } else {
            final updatedUser = state.user!.copyWith(cover_picture: imageUrl);
            add(UpdateProfile(updatedUser));
          }
        }
      } catch (e) {
        emit(ProfileContentFailure(error: e.toString()));
      }
    });

    on<UpdateName>((event, emit) async {
      emit(ProfileContentLoading());
      try {
        if (state.user == null) {
          final user = await profileContentService.getProfile(supabaseUser!.id);
          final updatedUser = user.copyWith(name: event.name);
          add(UpdateProfile(updatedUser));
        } else {
          final updatedUser = state.user!.copyWith(name: event.name);
          add(UpdateProfile(updatedUser));
        }
      } catch (e) {
        emit(ProfileContentFailure(error: e.toString()));
      }
    });

    on<UpdatePseudo>((event, emit) async {
      emit(ProfileContentLoading());
      try {
        if (state.user == null) {
          final user = await profileContentService.getProfile(supabaseUser!.id);
          final updatedUser = user.copyWith(pseudo: event.pseudo);
          add(UpdateProfile(updatedUser));
        } else {
          final updatedUser = state.user!.copyWith(pseudo: event.pseudo);
          add(UpdateProfile(updatedUser));
        }
      } catch (e) {
        emit(ProfileContentFailure(error: e.toString()));
      }
    });
  }
  ProfileContentService profileContentService;
}
