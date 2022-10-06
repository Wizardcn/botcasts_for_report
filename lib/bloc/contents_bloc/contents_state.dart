part of 'contents_bloc.dart';

abstract class ContentsState extends Equatable {
  const ContentsState();

  @override
  List<Object> get props => [];
}

class ContentsInitial extends ContentsState {}

class ContentsLoading extends ContentsState {}

class ContentsError extends ContentsState {
  final String message;

  const ContentsError(this.message);
}

class ContentsFinished extends ContentsState {
  final List<Content> contents;

  const ContentsFinished(this.contents);

  // @override
  // List<Object> get props => contents;
}
