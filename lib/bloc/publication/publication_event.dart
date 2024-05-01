part of 'publication_bloc.dart';

sealed class PublicationEvent extends Equatable {
  const PublicationEvent();

  @override
  List<Object> get props => [];
}

class PublishPublication extends PublicationEvent {
  const PublishPublication(this.publication, this.publicationItem);
  final PublicationModel publication;
  final PublicationItemModel publicationItem;
}
