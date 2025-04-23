import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRuter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
      routes: [
        
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.routeName,
          builder: (context, state) {
            // print('Router');
            final movieId = state.pathParameters['id'] ?? 'no-id';
            return MovieScreen( movieId: movieId ); 
          } 
        ),
        
      ]
    ),
  ],
);