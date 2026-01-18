import 'package:flutter/material.dart';
import 'package:core/core.dart';

class HomeTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/home-tv';

  final VoidCallback toggleDrawer;
  final Widget homeTVSereisPageContent;

  const HomeTvPage({
    Key? key,
    required this.toggleDrawer,
    required this.homeTVSereisPageContent,
  }) : super(key: key);

  @override
  _HomeTvPageState createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
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
              Navigator.pushNamed(context, SEARCH_TV_SERIES_ROUTE);
            },
            icon: Icon(Icons.search),
          ),
        ],
        leading: IconButton(
          onPressed: widget.toggleDrawer,
          icon: Icon(Icons.menu),
        ),
      ),
      body: widget.homeTVSereisPageContent,
    );
  }
}
