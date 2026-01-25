import 'dart:ui';

import 'package:core/styles/styles.dart';
import 'package:core/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/bloc/bloc.dart';
import 'package:movie/presentation/pages/pages.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:about/about.dart';
import 'package:core/presentation/widgets/custom_drawer.dart';
import 'package:search/presentation/bloc/bloc.dart';
import 'package:search/presentation/pages/pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';
import 'package:watchlist/presentataion/bloc/watchlist_bloc.dart';
import 'package:watchlist/presentataion/pages/pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
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
            homeTVSeriesPageContent: HomeTVPageContent(),
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
                    homeTVSeriesPageContent: HomeTVPageContent(),
                    homeMoviePageContent: HomeMoviePageContent(),
                  ),
                ),
              );

            case popularMoviesRoute:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case topRatedMovieRoute:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case detailMovieRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case searchMovieRoute:
              return CupertinoPageRoute(builder: (_) => SearchMoviePage());

            case popularTVSeriesRoute:
              return CupertinoPageRoute(builder: (_) => PopularTVPage());
            case topRatedTVSeriesRoute:
              return CupertinoPageRoute(builder: (_) => TopRatedTVPage());
            case detailTVSeriesRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TVDetailPage(id: id),
                settings: settings,
              );
            case searchTVSeriesRoute:
              return CupertinoPageRoute(builder: (_) => SearchTvPage());

            case watchlistRoute:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case aboutRoute:
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
