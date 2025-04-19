

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environments {

  static String theMovieDbKey = dotenv.env['THE_MOVIE_DB_API_KEY'] ?? 'No value found';

}