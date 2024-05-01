part of 'publication_bloc.dart';

sealed class PublicationState extends Equatable {
  const PublicationState();
  
  @override
  List<Object> get props => [];
}

final class PublicationInitial extends PublicationState {}

final class PublishLoading extends PublicationState {}

final class PublishSuccess extends PublicationState {}

final class PublishFailure extends PublicationState {
  PublishFailure({required this.error});
  final String error;
}

