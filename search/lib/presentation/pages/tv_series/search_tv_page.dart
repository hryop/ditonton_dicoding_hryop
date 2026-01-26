import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:search/presentation/bloc/tv_series/search_tv_series_bloc.dart';

class SearchTvPage extends StatelessWidget {
  static const routeName = '/search_tv';

  const SearchTvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search TV Series')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                context.read<SearchTvSeriesBloc>().add(OnQueryTVSeriesChanged(query));
              },
              onChanged: (query) {
                context.read<SearchTvSeriesBloc>().add(OnQueryTVSeriesChanged(query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text('Search Result', style: heading6),
            BlocBuilder<SearchTvSeriesBloc, SearchTvSeriesState>(
              builder: (context, state) {
                if (state is SearchTvSeriesLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is SearchTvSeriesHasDataState) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final tvSeries = result[index];
                        return MovieCard(
                          tvSeries.toMovieEntity(),
                          contentType: DatabaseHelper.contentTypeTV,
                        );
                      },
                      itemCount: result.length,
                    ),
                  );
                } else if (state is SearchTvSeriesErrorState) {
                  return Expanded(child: Center(child: Text(state.message)));
                } else {
                  return Expanded(child: SizedBox());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
