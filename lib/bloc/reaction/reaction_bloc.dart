import 'package:bloc/bloc.dart';
import 'package:decimal/service/reaction_service.dart';
import 'package:equatable/equatable.dart';

part 'reaction_event.dart';
part 'reaction_state.dart';

class ReactionBloc extends Bloc<ReactionEvent, ReactionState> {
  ReactionBloc({required this.reactionService}) : super(ReactionInitial()) {
    on<AddReaction>((event, emit) async {
      emit(ReactionLoading());
      try {
        await reactionService.addReaction(event.reactionType, event.publication_id);
        emit(ReactionSuccess());
      } catch (e) {
        emit(ReactionFailure(error: e.toString()));
      }
    });

    on<RemoveReaction>((event, emit) async {
      emit(ReactionLoading());
      try {
        await reactionService.removeReaction(event.reactionType, event.publication_id);
        emit(ReactionSuccess());
      } catch (e) {
        emit(ReactionFailure(error: e.toString()));
      }
    });

    on<AddRepost>((event, emit) async {
      emit(ReactionLoading());
      try {
        await reactionService.addRepost(event.publication_id);
        emit(ReactionSuccess());
      } catch (e) {
        emit(ReactionFailure(error: e.toString()));
      }
    });

    on<RemoveRepost>((event, emit) async {
      emit(ReactionLoading());
      try {
        await reactionService.removeRepost(event.publication_id);
        emit(ReactionSuccess());
      } catch (e) {
        emit(ReactionFailure(error: e.toString()));
      }
    });
  }
  ReactionService reactionService;
}
