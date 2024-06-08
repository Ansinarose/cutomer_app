


// import 'package:customer_application/bloc/bloc/app_event.dart';
// import 'package:customer_application/features/splash/views/splash_screen.dart';
// import 'package:customer_application/firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'bloc/bloc/app_bloc.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp(
//   options: DefaultFirebaseOptions.currentPlatform,
// );
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//           useMaterial3: true,
//         ),
//         home: BlocProvider(
//           create: (context) => splashBloc()..add(StartSplash()),
//           child: const SplashScreen(),
//        )
      
//        );
//   }
// }




import 'package:customer_application/bloc/bloc/app_event.dart';
import 'package:customer_application/features/auth/views/login_screen.dart';
import 'package:customer_application/features/auth/views/signup_screen.dart';
import 'package:customer_application/features/home/views/home_screen.dart';
import 'package:customer_application/features/splash/views/splash_screen.dart';
import 'package:customer_application/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc/app_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),

        initialRoute: '/',
      routes: {
        '/':(context) => SplashPageWrapper(),
        '/login':(context) => LoginScreenWrapper(),
        '/home':(context) => HomeScreenWrapper(),
        '/signup':(context) => SignupScreenWrapper()
      },
      
       );
  }
}