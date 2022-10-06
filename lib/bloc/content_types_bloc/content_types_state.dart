part of 'content_types_bloc.dart';

abstract class ContentTypesState extends Equatable {
  const ContentTypesState();

  @override
  List<Object> get props => [];
}

class ContentTypesInitial extends ContentTypesState {}

class ContentTypesLoading extends ContentTypesState {}

class ContentTypesError extends ContentTypesState {
  final String message;

  const ContentTypesError(this.message);
}

class ContentTypesFinished extends ContentTypesState {
  final List<ContentType> contentTypes;

  const ContentTypesFinished(this.contentTypes);

  @override
  List<Object> get props => contentTypes;
}
