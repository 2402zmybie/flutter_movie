import 'package:flutter/material.dart';
import 'left_drawer.dart';
import 'tabs/list.dart';
import 'tabs/coming_soon.dart';
import 'tabs/hot_line.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final pages = [MovieList(mt: 'in_theaters'),ComingSoon(mt: 'coming_soon'),HotLine(mt: 'top250')];
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Movie'),
          centerTitle: true,
          actions: <Widget>[
            Container(
              child: Icon(Icons.search),
              padding: EdgeInsets.only(right: 10),
            )
          ],
        ),
        drawer: LeftDrawer(),
        body: pages[_index],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _index,
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.movie_filter),
                title: Text('正在热映')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.movie_filter),
                title: Text('即将上映')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.movie_filter),
                title: Text('正在热映')
            ),
          ],
        ),
      ),
    );
  }
}

