import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wecode/src/screens/screenHandler.dart';

class WeCodeApp extends StatelessWidget {
  const WeCodeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'WeCode',
        theme: ThemeData(
          // brightness: Brightness.dark,
          fontFamily: GoogleFonts.roboto().fontFamily,
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
            titleMedium: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.roboto().fontFamily),
          ),
          appBarTheme: AppBarTheme(
            color: Colors.red,
            titleTextStyle: TextStyle(
              color: Colors.grey[800],
              fontSize: 26,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.roboto().fontFamily,
            ),
          ),
          buttonTheme: Theme.of(context).buttonTheme.copyWith(
                buttonColor: Colors.amber,
                textTheme: ButtonTextTheme.primary,
              ),
        ),
        home: ScreenHandler());
  }
}
