import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/firebase_options.dart';
import 'package:survey_app/screens/auth_wrapper.dart';
import 'providers/app_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(),
        darkTheme: ThemeData.dark(), // standard dark theme
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        title: 'Survey Hub',
        home: const AuthenticationWraper() // can do the authentication right here
      ),
    );
  }
}

