// ignore_for_file: non_constant_identifier_names

part of 'reaction_bloc.dart';

sealed class ReactionEvent extends Equatable {
  const ReactionEvent();

  @override
  List<Object> get props => [];
}

final class AddReaction extends ReactionEvent {
  const AddReaction(this.reactionType, this.publication_id);

  final String reactionType;
  final int publication_id;

  @override
  List<Object> get props => [publication_id];
}

final class RemoveReaction extends ReactionEvent {
  const RemoveReaction(this.reactionType, this.publication_id);

  final String reactionType;
  final int publication_id;

  @override
  List<Object> get props => [publication_id];
}

final class AddRepost extends ReactionEvent {
  const AddRepost(this.publication_id);

  final int publication_id;

  @override
  List<Object> get props => [publication_id];
}

final class AddComment extends ReactionEvent {
  const AddComment(this.publication_id, this.comment);

  final int publication_id;
  final String comment;

  @override
  List<Object> get props => [publication_id, comment];
}