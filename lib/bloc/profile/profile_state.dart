part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class FetchLoading extends ProfileState {}

final class GetProfileSuccess extends ProfileState {
  const GetProfileSuccess({required this.profile});

  final CustomUser profile;

  @override
  List<Object> get props => [profile];
}

final class FetchProfileSuccess extends ProfileState {
  const FetchProfileSuccess({
    required this.fetchStoriesSuccess,
    required this.fetchPicsSuccess,
    required this.fetchAllSuccess,
    required this.fetchDescriptionSuccess,
    required this.fetchContactSuccess,
    required this.fetchContactcNumberSuccess,
  });

  final CustomUser fetchDescriptionSuccess;
  final Map<String, dynamic> fetchContactSuccess;
  final Map<String, dynamic> fetchPicsSuccess;
  final Map<String, dynamic> fetchStoriesSuccess;
  final Map<String, dynamic> fetchAllSuccess;
  final Map<String, dynamic> fetchContactcNumberSuccess;

  @override
  List<Object> get props => [
        fetchAllSuccess,
        fetchStoriesSuccess,
        fetchPicsSuccess,
        fetchDescriptionSuccess,
        fetchContactSuccess,
        fetchContactcNumberSuccess,
      ];
}

final class FetchProfileUserSuccess extends ProfileState {
  const FetchProfileUserSuccess({
    required this.fetchStoriesSuccess,
    required this.fetchPicsSuccess,
    required this.fetchAllSuccess,
    required this.fetchDescriptionSuccess,
    required this.fetchContactSuccess,
    required this.fetchContactsNumberSuccess,
  });

  final CustomUser fetchDescriptionSuccess;
  final Map<String, dynamic> fetchContactSuccess;
  final Map<String, dynamic> fetchPicsSuccess;
  final Map<String, dynamic> fetchStoriesSuccess;
  final Map<String, dynamic> fetchAllSuccess;
  final Map<String, int> fetchContactsNumberSuccess;

  @override
  List<Object> get props => [
        fetchAllSuccess,
        fetchStoriesSuccess,
        fetchPicsSuccess,
        fetchDescriptionSuccess,
        fetchContactSuccess,
        fetchContactsNumberSuccess,
      ];
}

final class FetchFailure extends ProfileState {
  const FetchFailure({required this.error});
  final String error;
}
