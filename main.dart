import 'package:flutter/material.dart '; 
import 'package:flutter_application_1/models/app_config.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/service/http_service.dart';
import 'dart:convert';

import 'package:get_it/get_it.dart';

// STORY TIME: These lines are like the tools you take from a toolbox before you build something. 
// Flutter provides the basic building blocks for making the app. The "models," "pages," and "services"
// are the parts of your app you’ve already made, like bricks and windows. "GetIt" is a special helper
// that remembers important tools, and "dart:convert" helps you decode some special data, like turning a secret code into normal text.

void main() async {
  // The main function is like starting a magical train ride. This is the FIRST place your app begins.
  // Flutter is telling the app engine, “Hey, get ready to start this amazing app journey!”

  await loadConfig();
  // Before the journey starts, Flutter pauses and opens a map (a JSON file!) 
  // to figure out where things are. It's like looking at the directions for the trip.

  WidgetsFlutterBinding.ensureInitialized();
  // Here, Flutter is setting up the train’s control system. Without this, the train cannot work smoothly.

  registerHTTpService();
  // The app now gets another helper (an HTTP Service) ready. This helper will connect with online data,
  // like a friendly postman fetching letters (or data) from the internet.

  runApp(const MyApp());
  // Finally, Flutter says, “Now, it’s time to drive the train!” The journey begins here as MyApp starts.
}

Future<void> loadConfig() async {
  String _configContent =
      await rootBundle.loadString('assets/config/main.json');
  // This part is like opening a treasure chest called "main.json."
  // The app finds it in the "assets/config/" folder and carefully reads what's inside.
  
  Map _configData = jsonDecode(_configContent);
  // After finding the treasure, the app uses a magical decoder (jsonDecode) to turn 
  // the chest’s items into something it can read and understand — like a list of secrets.

  GetIt.instance.registerSingleton<AppConfig>(
    AppConfig(COIN_API_BASE_URL: _configData['COIN_API_BASE_URL']),
  );
  // Now, Flutter takes an important secret from the chest (like the URL for an API),
  // gives it to its memory keeper (GetIt), and says, “Hey, hold on to this for me, I’ll need it later.”
}

void registerHTTpService() {
  GetIt.instance.registerSingleton<HTTpService>(HTTpService());
  // Here's the part where Flutter tells GetIt to remember the HTTP helper (postman) we’ll use.
  // "HTTPService" is the helper that fetches data from the internet (like coin prices).
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // "MyApp" is like the control room of the train, where the main driver sits and plans the trip.

  @override
  Widget build(BuildContext context) {
    // The "build" function sets up how the train looks, feels, and behaves.

    return MaterialApp(
      title: 'Coin Cap',
      // This is the name on the train, just like naming your bike "Lightning Express."
      
      theme: ThemeData(
          primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.yellow),
      // The app has a theme, which is like choosing colors and decorations for your train: 
      // "blue" is the paint for primary features, and "yellow" is the background.

      home: MyHomepage(),
      // Finally, the app sets its "Home Screen" — the first page passengers see when they board the train.
    );
  }
}

// This code is the blueprint for a basic app, with steps like:
// 1. Reading instructions (loading config),
// 2. Getting helpers ready (registering services),
// 3. Designing the train (app UI),
// 4. And making everything work together seamlessly.

