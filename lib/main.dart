import 'package:fireball/firebase_options.dart';
import 'package:fireball/models/user.dart';
import 'package:fireball/screen/wrapper.dart';
import 'package:fireball/service/auth.dart';
import 'package:fireball/theme/theme.dart';
import 'package:fireball/theme/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_api_availability/google_api_availability.dart';

// Import ProviderInstaller
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // Hàm này để cài đặt ProviderInstaller khi khởi động

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeProvider>(context).themeData,
        darkTheme: darkmode,
        home: const Wrapper(),
      ),
    );
  }
}

Future<void> checkGooglePlayServices() async {
  GooglePlayServicesAvailability availability = await GoogleApiAvailability
      .instance
      .checkGooglePlayServicesAvailability();

  switch (availability) {
    case GooglePlayServicesAvailability.success:
      print('Google Play Services are available.');
      break;
    case GooglePlayServicesAvailability.serviceMissing:
      print('Google Play Services are missing.');
      break;
    case GooglePlayServicesAvailability.serviceVersionUpdateRequired:
      print('Google Play Services require an update.');
      break;
    default:
      print('Google Play Services have an issue: $availability');
  }
}
