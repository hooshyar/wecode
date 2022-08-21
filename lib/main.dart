import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wecode/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wecode/src/models/vacancy_data_model.dart';
import 'package:wecode/src/providers/user_provider.dart';
import 'package:wecode/src/temp/number_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  final favBox = await Hive.openBox('favBox');
  // favBox.delete('jobId');
  // debugPrint(favBox.get('jobId'));

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
