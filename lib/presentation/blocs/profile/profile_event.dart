part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {

  @override
  List<Object?> get props => [];

}

class DeleteMyAccountEvent extends ProfileEvent {

  final DeleteMyAccountParams params;
  DeleteMyAccountEvent({required this.params});

  @override
  List<Object?> get props => [params];

}