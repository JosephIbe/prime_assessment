import 'package:equatable/equatable.dart';

class DeleteMyAccountParams extends Equatable {

  final String userId;

  const DeleteMyAccountParams({
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
    "userId": userId,
  };

  @override
  List<Object?> get props => [userId,];

}