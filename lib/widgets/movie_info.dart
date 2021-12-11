import 'package:flutter/material.dart';

class MovieInfo extends StatefulWidget {
  final int id;

  MovieInfo({Key key, @required this.id}) : super(key: key);

  @override
  _MovieInfoState createState() => _MovieInfoState(id);
}
  class _MovieInfoState extends State<MovieInfo> {
    final int id;
    _MovieInfoState(this.id);

    @override
    Widget build(BuildContext context) {
      return Container(

      );
  }
}