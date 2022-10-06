part of 'content_types_bloc.dart';

abstract class ContentTypesEvent extends Equatable {
  const ContentTypesEvent();

  @override
  List<Object> get props => [];
}

class RequestContentTypesEvent extends ContentTypesEvent {}
