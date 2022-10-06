import 'package:bloc/bloc.dart';
import 'package:botcasts/models/contents.dart';
import 'package:botcasts/services/database.dart';
import 'package:equatable/equatable.dart';

part 'contents_event.dart';
part 'contents_state.dart';

class ContentsBloc extends Bloc<ContentsEvent, ContentsState> {
  ContentsBloc() : super(ContentsInitial()) {
    on<AppStartUpEvent>((event, emit) async {
      emit(ContentsLoading());
      try {
        List<Content> contents = await DatabaseService().getAllContents();
        emit(ContentsFinished(contents));
      } catch (e) {
        emit(ContentsError(e.toString()));
      }
    });
  }
}
