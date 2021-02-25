import 'package:customerservice/screens/splashsceen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/localization_delegate.dart';
import 'package:flutter_translate/localized_app.dart';

void main() async {
  Paint.enableDithering = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en_US',
      supportedLocales: [
        'en_US',
        'ar',
      ]);

  runApp(
    LocalizedApp(
      delegate,
      MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          localizationDelegate
        ],
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,
        theme: ThemeData(
          fontFamily: 'Cairo'
        ),
        home: SplashScreen(),
      ),
    );
  }
}
