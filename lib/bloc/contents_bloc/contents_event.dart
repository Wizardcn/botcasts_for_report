part of 'contents_bloc.dart';

abstract class ContentsEvent extends Equatable {
  const ContentsEvent();

  @override
  List<Object> get props => [];
}

class AppStartUpEvent extends ContentsEvent {}

class SearchEvent extends ContentsEvent {
  final String searchText;

  const SearchEvent(this.searchText);
}
