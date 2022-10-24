import 'package:flutter/material.dart';

<<<<<<< Updated upstream
void main() {
=======
import 'UserProfile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MongoDatabase.connect();
>>>>>>> Stashed changes
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
    return MaterialApp() ;
=======
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UserProfile(),
    );
>>>>>>> Stashed changes
  }
}
