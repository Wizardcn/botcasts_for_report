import 'package:bloc/bloc.dart';
import 'package:botcasts/models/content_types.dart';
import 'package:botcasts/services/database.dart';
import 'package:equatable/equatable.dart';

part 'content_types_event.dart';
part 'content_types_state.dart';

class ContentTypesBloc extends Bloc<ContentTypesEvent, ContentTypesState> {
  ContentTypesBloc() : super(ContentTypesInitial()) {
    on<RequestContentTypesEvent>((event, emit) async {
      emit(ContentTypesLoading());
      try {
        List<ContentType> contentTypes =
            await DatabaseService().getContentTypes();
        emit(ContentTypesFinished(contentTypes));
      } catch (e) {
        emit(ContentTypesError(e.toString()));
      }
    });
  }
}
