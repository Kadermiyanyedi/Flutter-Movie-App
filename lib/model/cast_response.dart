import 'package:movie_app/model/cast.dart';

class CastResponse {
  final List<Cast> casts;
  final String error;

  CastResponse(this.casts, this.error);

  CastResponse.fromJson(Map<String, dynamic> json):
      casts = (json["casts"] as List).map((i) => new Cast.fromJson(i)).toList(),
      error = "";

  CastResponse.withError(String errorValue):
      casts = [],
      error = errorValue;
}