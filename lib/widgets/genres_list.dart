import 'package:flutter/material.dart';
import 'package:movie_app/model/genre.dart';
import 'package:movie_app/style/theme.dart' as style;

class GenresList extends StatefulWidget {
  final List<Genre> genres;
  const GenresList({Key? key, required this.genres}) : super(key: key);

  @override
  _GenresListState createState() {
    return _GenresListState(genres);
  }
}

class _GenresListState extends State<GenresList> with SingleTickerProviderStateMixin {
  late final List<Genre> genres;
  late TabController _tabController;
  _GenresListState(List<Genre> genres);



  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: genres.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      child: DefaultTabController(
        length: genres.length,
        child: Scaffold(
          backgroundColor: style.Colors.mainColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: AppBar(
              backgroundColor: style.Colors.mainColor,
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: style.Colors.secondColor,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3.0,
                unselectedLabelColor: style.Colors.titleColor,
                labelColor: Colors.white,
                isScrollable: true,
                tabs: genres.map((Genre genre) {
                  return Container(
                    padding: const EdgeInsets.only(bottom: 15.0, top: 10.0),
                    child: Text(genre.name.toUpperCase(), style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold
                    )));
                }).toList(),
                ),
              ),
            ),
          body: TabBarView(
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            children: [],
          ),
          ),
        ),
      );
  }
}
