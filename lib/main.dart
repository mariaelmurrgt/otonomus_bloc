import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otonomus/business_logic/authentication/bloc/authentication_bloc.dart';
import 'package:otonomus/business_logic/signup/bloc/signup_bloc.dart';
import 'package:otonomus/data/repository/auth_repository.dart';
import 'package:otonomus/navigation/app_routes.dart';
import 'package:otonomus/navigation/handle_navigation.dart';
import 'package:otonomus/presentation/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => AuthRepository(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthenticationBloc(
                authRepository: RepositoryProvider.of<AuthRepository>(context),
              ),
            ),
            BlocProvider(
              create: (context) => SignupBloc(
                RepositoryProvider.of<AuthRepository>(context),
              ),
            ),
          ],
          child: MaterialApp(
            navigatorKey: HandleNavigation.navigatorKey,
            initialRoute: '/signupmain',
            onGenerateRoute: onGenerateRoute,
          ),
        ));
  }
}

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    // case AppRoutes.loadingScreenRoute:
    //   return MaterialPageRoute(builder: (BuildContext context) {
    //     return LoadingScreen();
    //   });
    // case AppRoutes.homeRoute:
    //   return MaterialPageRoute(builder: (BuildContext context) {
    //     return HomePageScreen();
    //   });

    // case AppRoutes.logInRoute:
    //   return MaterialPageRoute(builder: (BuildContext context) {
    //     return LoginPage();
    //   });

    case AppRoutes.singUpMainRoute:
      return MaterialPageRoute(builder: (BuildContext context) {
        return SignUpPage();
      });
    // case AppRoutes.singUpRoute:
    //   return MaterialPageRoute(builder: (BuildContext context) {
    //     return CompleteSignUp();
    //   });
    // case AppRoutes.displayRoute:
    //   return MaterialPageRoute(builder: (BuildContext context) {
    //     return Display();
    //   });

    default:
      return MaterialPageRoute(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Not Found'),
          ),
          body: Text('Page not found!'),
        );
      });
  }
}