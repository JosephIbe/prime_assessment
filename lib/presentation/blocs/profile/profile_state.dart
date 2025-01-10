part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileStateInitial extends ProfileState {}

class ProfileStateLoading extends ProfileState {}

class ProfileStateDeleteMyAccountSuccess extends ProfileState {}

class ProfileStateFailure extends ProfileState {

  final String errorMessage;
  ProfileStateFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];

}