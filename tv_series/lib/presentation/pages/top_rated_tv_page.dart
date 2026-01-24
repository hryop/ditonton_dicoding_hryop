import 'package:core/presentation/widgets/empty_result_widget.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_list/tv_list_bloc.dart';

class TopRatedTVPage extends StatefulWidget {
  static const routeName = '/top-rated-tv';

  const TopRatedTVPage({super.key});

  @override
  TopRatedTVPageState createState() => TopRatedTVPageState();
}

class TopRatedTVPageState extends State<TopRatedTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask((){
      if(mounted) context.read<TVListBloc>().add(OnGetTopRatedTVSeries());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Top Rated Tv Series')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TVListBloc, TVListState>(
          builder: (context, state) {
            if (state is TopRatedTVSeriesLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TopRatedTVSeriesHasDataState) {
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
            } else if (state is TopRatedTVSeriesErrorState) {
              return EmptyResultWidget(state.message);
            }

            return EmptyResultWidget("There isn't any top rated tv series");

          },
        ),
      ),
    );
  }
}
