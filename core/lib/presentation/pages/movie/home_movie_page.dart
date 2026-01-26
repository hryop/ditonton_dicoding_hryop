import 'package:flutter/material.dart';
import 'package:core/core.dart';

class HomeMoviePage extends StatefulWidget {
  static const routeName = '/home-movie';

  final VoidCallback toggleDrawer;
  final Widget homeMoviePageContent;

  const HomeMoviePage({
    super.key,
    required this.toggleDrawer,
    required this.homeMoviePageContent,
  });

  @override
  HomeMoviePageState createState() => HomeMoviePageState();
}

class HomeMoviePageState extends State<HomeMoviePage> {
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
              Navigator.pushNamed(context, searchMovieRoute);
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
