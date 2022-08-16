import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecode/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wecode/src/providers/user_provider.dart';
import 'package:wecode/src/temp/number_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NumberProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider())
      ],
      child: WeCodeApp(),
    ),
  );
}
