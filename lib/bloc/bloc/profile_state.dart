part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class FetchLoading extends ProfileState {}

final class FetchAllSuccess extends ProfileState {
  const FetchAllSuccess({required this.fetchStoriesSuccess, required this.fetchPicsSuccess, required this.fetchAllSuccess, required this.fetchDescriptionSuccess, required this.fetchContactSuccess});

  final CustomUser fetchDescriptionSuccess;
  final Map<String, dynamic> fetchContactSuccess;
  final Map<String, dynamic> fetchPicsSuccess;
  final Map<String, dynamic> fetchStoriesSuccess;
  final Map<String, dynamic> fetchAllSuccess;

  @override
  List<Object> get props => [fetchAllSuccess, fetchStoriesSuccess, fetchPicsSuccess, fetchDescriptionSuccess, fetchContactSuccess];
}

final class FetchFailure extends ProfileState {
  const FetchFailure({required this.error});
  final String error;
}
