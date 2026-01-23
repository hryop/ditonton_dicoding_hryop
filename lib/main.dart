import 'package:core/styles/styles.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'package:movie/presentation/bloc/movie_recommendations/movie_recommendations_bloc.dart';
import 'package:movie/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:movie/presentation/pages/home_movie_page_content.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:movie/presentation/provider/movie_detail_notifier.dart';
import 'package:movie/presentation/provider/movie_list_notifier.dart';
import 'package:movie/presentation/provider/popular_movies_notifier.dart';
import 'package:movie/presentation/provider/top_rated_movies_notifier.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:about/about.dart';
import 'package:core/presentation/widgets/custom_drawer.dart';
import 'package:search/presentation/bloc/bloc.dart';
import 'package:search/presentation/pages/pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_list/tv_list_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_recommendations/tv_recommendations_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_watchlist/watchlist_bloc.dart';
import 'package:tv_series/presentation/pages/home_tv_page_content.dart';
import 'package:tv_series/presentation/pages/popular_tv_page.dart';
import 'package:tv_series/presentation/pages/top_rated_tv_page.dart';
import 'package:tv_series/presentation/pages/tv_detail_page.dart';
import 'package:watchlist/presentataion/bloc/watchlist_bloc.dart';
import 'package:watchlist/presentataion/pages/pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.locator<MovieListNotifier>()),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        BlocProvider(create: (_) => di.locator<SearchBloc>()),
        BlocProvider(create: (_) => di.locator<SearchTvSeriesBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistBloc>()),
        BlocProvider(create: (_) => di.locator<TVListBloc>()),
        BlocProvider(create: (_) => di.locator<TVDetailBloc>()),
        BlocProvider(create: (_) => di.locator<TVRecommendationsBloc>()),
        BlocProvider(create: (_) => di.locator<TVWatchlistBloc>()),
        BlocProvider(create: (_) => di.locator<MovieListBloc>()),
        BlocProvider(create: (_) => di.locator<MovieDetailBloc>()),
        BlocProvider(create: (_) => di.locator<MovieWatchlistBloc>()),
        BlocProvider(create: (_) => di.locator<MovieRecommendationsBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: colorScheme,
          primaryColor: richBlack,
          scaffoldBackgroundColor: richBlack,
          textTheme: textTheme,
          drawerTheme: kDrawerTheme,
        ),
        home: Material(
          child: CustomDrawer(
            homeTVSeriesPageContent: HomeTvPageContent(),
            homeMoviePageContent: HomeMoviePageContent(),
          ),
        ),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(
                builder: (_) => Material(
                  child: CustomDrawer(
                    homeTVSeriesPageContent: HomeTvPageContent(),
                    homeMoviePageContent: HomeMoviePageContent(),
                  ),
                ),
              );

            case POPULAR_MOVIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TOP_RATED_MOVIE_ROUTE:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case DETAIL_MOVIE_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SEARCH_MOVIE_ROUTE:
              return CupertinoPageRoute(builder: (_) => SearchMoviePage());

            case POPULAR_TV_SERIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => PopularTvPage());
            case TOP_RATED_TV_SERIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => TopRatedTvPage());
            case DETAIL_TV_SERIES_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case SEARCH_TV_SERIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => SearchTvPage());

            case WATCHLIST_ROUTE:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case ABOUT_ROUTE:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return Scaffold(
                    body: Center(child: Text('Page not found :(')),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
