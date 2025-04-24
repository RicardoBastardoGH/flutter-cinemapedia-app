
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




final actorsByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>((ref) {
  final actorsRepository = ref.watch( actorRepositoryProvider );
  return ActorsByMovieNotifier( actorsRepository.getActorsByMovie );
});

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

// Notifier to manage the state of a movie map
class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {

  final GetActorsCallback getActors;

  ActorsByMovieNotifier(this.getActors) : super({});  

  Future <void> loadActor(String movieId) async {
    if (state[movieId] != null) return;

    final List<Actor> actors = await getActors(movieId);

    state = {
      ...state,
      movieId: actors,
    };
  }
  
}
