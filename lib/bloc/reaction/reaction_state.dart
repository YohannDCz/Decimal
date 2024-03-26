part of 'reaction_bloc.dart';

sealed class ReactionState extends Equatable {
  const ReactionState();
  
  @override
  List<Object> get props => [];
}

final class ReactionInitial extends ReactionState {}

final class ReactionLoading extends ReactionState {}

final class ReactionSuccess extends ReactionState {}

final class ReactionFailure extends ReactionState {
  const ReactionFailure({required this.error});

  final String error;

  @override
  List<Object> get props => [error];
}