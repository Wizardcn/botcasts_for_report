import 'package:botcasts/bloc/content_types_bloc/content_types_bloc.dart';
import 'package:botcasts/bloc/contents_bloc/contents_bloc.dart';
import 'package:botcasts/models/content_types.dart';
import 'package:botcasts/shared/content_bar.dart';
import 'package:botcasts/shared/content_bar_loading.dart';
import 'package:botcasts/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ContentTypesBloc, ContentTypesState>(
        builder: (context, contentTypesState) {
          if (contentTypesState is ContentTypesFinished) {
            return BlocBuilder<ContentsBloc, ContentsState>(
              builder: (context, contentsState) {
                List<ContentType> contentTypes = contentTypesState.contentTypes;
                contentTypes.sort((a, b) =>
                    a.note.toLowerCase().compareTo(b.note.toLowerCase()));
                if (contentsState is ContentsInitial ||
                    contentsState is ContentsLoading) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: ListView(
                      children: contentTypes
                          .map((type) =>
                              ContentBarLoading(category: type.typeName))
                          .toList(),
                    ),
                  );
                } else if (contentsState is ContentsFinished) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: ListView(
                      children: contentTypes
                          .map((type) => ContentBar(
                                category: type.typeName,
                                contentList: contentsState.contents
                                    .where((content) =>
                                        content.contentType == type.typeNum)
                                    .toList(),
                              ))
                          .toList(),
                    ),
                  );
                } else {
                  // TODO: return please check your internet and try again alert
                  return Container();
                }
              },
            );
          } else {
            return const Loading();
          }
        },
      ),
    );
  }
}
