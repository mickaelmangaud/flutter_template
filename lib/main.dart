import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_template/firebase/firebase_options.dart';
import 'package:flutter_template/helpers/routes.dart';
import 'package:flutter_template/screens/root.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: RootScreen(),
      getPages: AppRoutes.pages,
      // initialRoute: AppRoutes.root,
    );
  }
}
