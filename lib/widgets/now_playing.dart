import 'package:flutter/material.dart';
import 'package:movie_app/bloc/get_now_playing_bloc.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/model/movie.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:movie_app/style/theme.dart' as Style;

class NowPlaying extends StatefulWidget {
  const NowPlaying({Key? key}) : super(key: key);

  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {

  @override
  void initState(){
    super.initState();
    nowPlayingMoviesBloc.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: nowPlayingMoviesBloc.subject.stream,
      builder:(context, AsyncSnapshot<MovieResponse> snapshot){
        if (snapshot.hasData) {
          /* != null yerine isNotEmpty kullandım.
          https://dart-lang.github.io/linter/lints/prefer_is_empty.html
          Ama bu if-else döngüsünde baya bir hata var.
          Örneğin aşağıdaki satırda veride hata varsa veri hata fırlatsın demek istemiş.
          Uyarlamaya çalıştım ancak olmadı.
          if (snapshot.data!.error.isNotEmpty) {
            return _buildErrorWidget(snapshot.!data.error);
          }*/
          return _buildNowPlayingWidget(snapshot.data as MovieResponse);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error as String);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25.0,
              width: 25.0,
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 4.0,
              ),
            )
          ],
        )
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Error occured: $error"),
          ],
        )
    );
  }

  Widget _buildNowPlayingWidget(MovieResponse data){
    List<Movie> movies = data.movies;
    if (movies.isEmpty) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: const <Widget>[
                Text(
                  "No Movies",
                )
              ],
            )
          ],
        ),
      );
    }
    else {
      return Container(
        height: 220,
        child: PageIndicatorContainer(
          align: IndicatorAlign.bottom,
          indicatorSpace: 8.0,
          padding: const EdgeInsets.all(5.0),
          indicatorColor: Style.Colors.titleColor,
          indicatorSelectorColor: Style.Colors.secondColor,
          shape: IndicatorShape.circle(size: 8.0),
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.take(5).length,
            itemBuilder: (context, index){
              return Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 220.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          image: NetworkImage('https://image.tmdb.org/t/p/original/' +  movies[index].backPoster),
                          fit: BoxFit.cover,
                      )
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Style.Colors.mainColor.withOpacity(1.0),
                        Style.Colors.mainColor.withOpacity(0.0)
                        ],
                       begin: Alignment.bottomCenter,
                       end: Alignment.topCenter,
                       stops: const [
                         0.0,
                         0.9
                       ]
                      ),
                    ),
                  )
                ],
              );

            },
          ),
          length: movies.take(5).length,
        ),
      );
    }
  }
}