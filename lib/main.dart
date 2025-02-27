import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mvvm_statemanagements/view_models/favorites_provider.dart';
import 'package:mvvm_statemanagements/view_models/movies_provider.dart';
import 'package:mvvm_statemanagements/view_models/theme_provider.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'service/init_getit.dart';
import 'service/navigation_service.dart';

void main() {
  setupLocator(); // Initialize GetIt
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.landscapeLeft,
    // DeviceOrientation.landscapeRight,
  ]).then((_) async {
    await dotenv.load(fileName: "assets/.env");
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider<MoviesProvider>(
          create: (_) => MoviesProvider(),
        ),
        ChangeNotifierProvider<FavoritesProvider>(
          create: (_) => FavoritesProvider(),
        ),
      ],
      child: Consumer(
        builder: (context, ThemeProvider themeProvider, child) => MaterialApp(
          navigatorKey: getIt<NavigationService>().navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Movies App',
          theme: themeProvider.themeData,
          home:
              //  const MoviesScreen(),
              const SplashScreen(),
          //const MovieDetailsScreen(), //const FavoritesScreen(), //const MoviesScreen(),
        ),
      ),
    );
  }
}
