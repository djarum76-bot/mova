import 'package:get/get.dart';
import 'package:mova/app/models/comment_model.dart';
import 'package:mova/app/models/favorite_model.dart';
import 'package:mova/app/models/film_model.dart';
import 'package:mova/app/models/gopay_model.dart';
import 'package:mova/app/models/movie_model.dart';
import 'package:mova/app/models/movies_model.dart';
import 'package:mova/app/models/series_model.dart';
import 'package:mova/app/models/top_1_model.dart';
import 'package:mova/app/models/user_model.dart';

class ModelController extends GetxController{
  final user = UserModel().obs;

  final movie = MovieModel().obs;
  final movies = MoviesModel().obs;

  final series = SeriesModel().obs;

  final top1 = Top1Model().obs;

  final favorites = FavoriteModel().obs;

  final film = FilmModel().obs;
  final newReleases = FilmModel().obs;
  final explore = FilmModel().obs;

  final comments = CommentModel().obs;

  final gopay = GopayModel().obs;
}