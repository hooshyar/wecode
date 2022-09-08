import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wecode/src/screens/auth/handler_screen.dart';

class WeCodeApp extends StatelessWidget {
  const WeCodeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //change to Getmaterial app to use the get package
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WeCode',
        theme: ThemeData(
          primaryColor: Colors.green,
          // brightness: Brightness.dark,
          fontFamily: GoogleFonts.roboto().fontFamily,
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
            titleMedium: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                fontFamily: GoogleFonts.roboto().fontFamily),
          ),
          appBarTheme: AppBarTheme(
            color: Colors.green,
            titleTextStyle: TextStyle(
              color: Colors.grey[800],
              fontSize: 26,
              fontWeight: FontWeight.w500,
              fontFamily: GoogleFonts.roboto().fontFamily,
              letterSpacing: 1,
            ),
          ),
          buttonTheme: Theme.of(context).buttonTheme.copyWith(
                buttonColor: Colors.amber,
                textTheme: ButtonTextTheme.primary,
              ),
        ),
        home: const HandlerScreen());
  }
}
