import 'package:core/utils/route.dart';
import 'package:core/utils/utils.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:watchlist/presentataion/bloc/watchlist_bloc.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistPage extends StatefulWidget {
  static const routeName = '/watchlist-movie';

  const WatchlistPage({super.key});

  @override
  WatchlistPageState createState() => WatchlistPageState();
}

class WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(callGetWatchlist);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    Future.microtask(callGetWatchlist);
  }

  void callGetWatchlist() {
    context.read<WatchlistBloc>().add(OnGetWatchListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Watchlist')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistBloc, WatchlistState>(
          builder: (context, state) {
            if (state is WatchlistLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is WatchlistHasDataState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movieTable = state.result[index];
                  return MovieCard(
                    movieTable.toMovieEntity(),
                    showContentType: true,
                    contentType:
                        movieTable.contentType ??
                        DatabaseHelper.CONTENT_TYPE_MOVIE,
                  );
                },
                itemCount: state.result.length,
              );
            } else if (state is WatchlistErrorState) {
              return Expanded(
                child: Center(
                  key: Key('error_message'),
                  child: Text(state.message),
                ),
              );
            } else {
              return Expanded(
                child: Center(
                  child: Text(
                    "No Watchlist at the momment\nLet's add new one!",
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
