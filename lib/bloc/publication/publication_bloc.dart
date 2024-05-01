import 'package:bloc/bloc.dart';
import 'package:decimal/models/publication_items_model.dart';
import 'package:decimal/models/publication_model.dart';
import 'package:decimal/service/profile_service.dart';
import 'package:equatable/equatable.dart';

part 'publication_event.dart';
part 'publication_state.dart';

class PublicationBloc extends Bloc<PublicationEvent, PublicationState> {
  PublicationBloc({required this.profileService}) : super(PublicationInitial()) {
    on<PublishPublication>((event, emit) async {
      emit(PublishLoading());

      try {
        await profileService.publishPublication(event.publication, event.publicationItem);

        emit(PublishSuccess());
      } catch (e) {
        emit(PublishFailure(error: e.toString()));
      }
    });
  }
  ProfileService profileService;

}
