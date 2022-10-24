import 'package:faydh/awarenessPost.dart';
import 'package:faydh/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:faydh/dbHelper/mongodb.dart';

import 'UserProfile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UserProfile(),
    );
  }
}
