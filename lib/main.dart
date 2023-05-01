import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/firebase_options.dart';
import 'package:survey_app/providers/app_provider.dart';
import 'package:survey_app/screens/auth_wrapper.dart';


/*
APP TO DO LIST:

Notifications
- Load Surveys with an end date instead of Datetime.now()
  or add Datetime.now().add(Duration(days:7)) for each new survey.
- Notifications can be sent on a specific day there are 2 options:
  1. Send a notification once a day until the surveys list is empty
  2. Send a notification the day before a survey is ending
- onNotificationRecieved onPayload funtions update

Other
- Make profile page nicer by inputing a few lines more of information
  exp. update email, username, password
- Forgot my password workflow
- Update load_data.dart with the JSON file before going live
- Add an App icon and give the project a new name
 */

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

