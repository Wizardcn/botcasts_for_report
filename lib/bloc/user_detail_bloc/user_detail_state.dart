part of 'user_detail_bloc.dart';

abstract class UserDetailState extends Equatable {
  const UserDetailState();

  @override
  List<Object> get props => [];
}

class UserDetailInitial extends UserDetailState {}

class UserDetailLoading extends UserDetailState {}

class UserDetailError extends UserDetailState {
  final String message;

  const UserDetailError(this.message);
}

class UserDetailFinished extends UserDetailState {
  final Users user;

  const UserDetailFinished(this.user);

  @override
  List<Object> get props => [
        user.id,
        user.uid,
        user.username,
        user.email,
        user.profilePicUrl,
      ];
}
