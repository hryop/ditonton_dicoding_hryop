import 'package:flutter/material.dart';
import 'package:core/core.dart';

class HomeTvPage extends StatefulWidget {
  static const routeName = '/home-tv';

  final VoidCallback toggleDrawer;
  final Widget homeTVSeriesPageContent;

  const HomeTvPage({
    super.key,
    required this.toggleDrawer,
    required this.homeTVSeriesPageContent,
  });

  @override
  HomeTvPageState createState() => HomeTvPageState();
}

class HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ditonton TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, searchTVSeriesRoute);
            },
            icon: Icon(Icons.search),
          ),
        ],
        leading: IconButton(
          onPressed: widget.toggleDrawer,
          icon: Icon(Icons.menu),
        ),
      ),
      body: widget.homeTVSeriesPageContent,
    );
  }
}
