import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:go_router/go_router.dart';

final appRuter = GoRouter(
  initialLocation: '/home',
  routes: [

// Comentario para guardar la version del curso

    StatefulShellRoute.indexedStack(
      builder:(context, state, child) {
        return HomeScreen(childView: child);
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) {
            return const HomeView();
          },
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
      ]
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              builder: (context, state) {
                return const FavoritesView();
              }
            ),
          ]
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              redirect: (context, state) => '/home',
            )
          ] 
          
        )
      ],
      
      
    )


    // Rutas padre/hija
    // GoRoute(
    //   path: '/',
    //   name: 'home',
    //   builder: (context, state) => const HomeScreen( childView: HomeView(),),
    //   routes: [
        

    //     GoRoute(
    //       path: 'movie/:id',
    //       name: MovieScreen.routeName,
    //       builder: (context, state) {
    //         // print('Router');
    //         final movieId = state.pathParameters['id'] ?? 'no-id';
    //         return MovieScreen( movieId: movieId ); 
    //       } 
    //     ),
        
    //   ]
    // ),
  ],
);