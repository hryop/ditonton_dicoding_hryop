import 'package:core/presentation/widgets/empty_result_widget.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_list/tv_list_bloc.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';

class PopularTVPage extends StatefulWidget {
  static const routeName = '/popular-tv';

  const PopularTVPage({super.key});

  @override
  PopularTVPageState createState() => PopularTVPageState();
}

class PopularTVPageState extends State<PopularTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask((){
      if(mounted) context.read<TVListBloc>().add(OnGetPopularAiringTVSeries());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Popular TV Series')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TVListBloc, TVListState>(
          builder: (context, state) {
            if (state is PopularTVSeriesLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PopularTVSeriesHasDataState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = state.result[index];
                  return MovieCard(
                    tvSeries.toMovieEntity(),
                    contentType: DatabaseHelper.CONTENT_TYPE_TV,
                  );
                },
                itemCount: state.result.length,
              );
            } else if (state is PopularTVSeriesErrorState) {
              return EmptyResultWidget(state.message);
            }

            return EmptyResultWidget("There isn't any popular tv series");

          },
        ),
      ),
    );
  }
}
