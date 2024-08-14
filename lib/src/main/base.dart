import 'package:flutter/material.dart';
import 'package:hop_app/src/main/log_in.dart';
import 'package:hop_app/src/registration/questions.dart';
//import 'package:hop_app/src/welcome_page/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hop_app/firebase_options.dart';
//Ignore and just run the app !!!!!!!!!!!!!!!!
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required before Firebase init
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hop Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 26, 71, 27)),
        //fontFamily: ,
        useMaterial3: true,
      ),
      home: const BaseApp(title: 'Hop Welcome Page'),
    );
  }
}

class BaseApp extends StatefulWidget //public API
{
  const BaseApp({super.key, required this.title});
  final String title;

  @override
  State<BaseApp> createState() => _BaseAppState();
}
class _BaseAppState extends State<BaseApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Entering Page'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/images/hello.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Welcome to Hop',
                style: TextStyle(fontSize: 48),
                textAlign: TextAlign.center,
              ),
              ElevatedButton( // Login Button
                onPressed: () {
                  Navigator.push(
                    context,
                     MaterialPageRoute(builder: (context) => const LoginPage()),
                     //MaterialPageRoute(builder: (context) => const MyHomePage()),
                  );
                },
                //takes user to login in if they already registered
                child: const Text('Log In'),
              ),
              ElevatedButton( // Register button
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()),
                  );
                },
                //takes user to register
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}