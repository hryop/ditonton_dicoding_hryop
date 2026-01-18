import 'package:flutter/material.dart';
import 'package:core/core.dart';

class HomeMoviePage extends StatefulWidget {
  static const ROUTE_NAME = '/home-movie';

  final VoidCallback toggleDrawer;
  final Widget homeMoviePageContent;

  const HomeMoviePage({
    Key? key,
    required this.toggleDrawer,
    required this.homeMoviePageContent,
  }) : super(key: key);

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ditonton Movies'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_MOVIE_ROUTE);
            },
            icon: Icon(Icons.search),
          ),
        ],
        leading: IconButton(
          onPressed: widget.toggleDrawer,
          icon: Icon(Icons.menu),
        ),
      ),
      body: widget.homeMoviePageContent,
    );
  }
}
