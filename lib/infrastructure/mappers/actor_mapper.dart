

import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToEntity( Cast cast) => Actor(
        id: cast.id,
        name: cast.name,
        profilePath: cast.profilePath != null
            ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
            : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5taINn-ULi-Gw1l5g7VkiDfkzm6btlLN_zpw-RyeFwsuiQBxrU45vQuc8ySnQes48TZ4&usqp=CAU',
        character: cast.character,
      );
}