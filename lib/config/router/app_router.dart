import 'package:go_router/go_router.dart';
import '../../presentation/screens/movies/home_screen.dart';

final appRuter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);