import 'package:about/about.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/presentation/pages/movie/home_movie_page.dart';
import 'package:ditonton/presentation/pages/tv/home_tv_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer();

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  String SELECTED_HOME = DatabaseHelper.CONTENT_TYPE_MOVIE;

  void toggle() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();

  void closeDrawer() =>
      _animationController.isDismissed ? {} : _animationController.reverse();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        _animationController.isDismissed
            ? {SystemNavigator.pop()}
            : _animationController.reverse();
      },
      child: GestureDetector(
        onTap: closeDrawer,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget? child) {
            double slide = 255.0 * _animationController.value;
            double scale = 1 - (_animationController.value * 0.3);

            return Stack(
              children: [
                _buildDrawer(),
                Transform(
                    transform: Matrix4.identity()
                      ..translate(slide)
                      ..scale(scale),
                    alignment: Alignment.centerLeft,
                    child: SELECTED_HOME == DatabaseHelper.CONTENT_TYPE_MOVIE
                        ? HomeMoviePage(
                            toggleDrawer: toggle,
                          )
                        : HomeTvPage(toggleDrawer: toggle))
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Container(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
              backgroundColor: Colors.grey.shade900,
            ),
            accountName: Text('hryop'),
            accountEmail: Text('https://github.com/hryop'),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
            ),
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('Movies'),
            onTap: () {
              SELECTED_HOME = DatabaseHelper.CONTENT_TYPE_MOVIE;
              toggle();
            },
          ),
          ListTile(
            leading: Icon(Icons.tv),
            title: Text('TV Series'),
            onTap: () {
              SELECTED_HOME = DatabaseHelper.CONTENT_TYPE_TV;
              toggle();
            },
          ),
          ListTile(
            leading: Icon(Icons.save_alt),
            title: Text('Watchlist'),
            onTap: () {
              Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
            },
            leading: Icon(Icons.info_outline),
            title: Text('About'),
          ),
        ],
      ),
    );
  }
}
