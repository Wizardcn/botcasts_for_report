part of 'user_detail_bloc.dart';

abstract class UserDetailEvent extends Equatable {
  const UserDetailEvent();

  @override
  List<Object> get props => [];
}

class RequestUserDetailEvent extends UserDetailEvent {
  final String? uid;

  const RequestUserDetailEvent(this.uid);
}
