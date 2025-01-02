// Once upon a time, there was a magical world of Flutter apps!
// In this world, we wanted to talk to a big online data house using "HTTP requests" (like sending letters to a faraway friend).
// So, we created a helper named "HTTpService" to do the talking for us. 

import 'package:dio/dio.dart';
// Dio is like a mailman. It helps us send and receive letters (data) over the internet.

import 'package:get_it/get_it.dart';
// GetIt is like a magic cupboard. We can store important items (services) in it and grab them easily later.

import 'package:flutter_application_1/models/app_config.dart';
// AppConfig is a little box where we keep important information (like secrets or keys to open doors).

// Now let's meet our helper class, "HTTpService".
class HTTpService {
  // First, we make a mailman named Dio.
  final Dio dio = Dio();

  // Here is a secret box to hold app settings, called `_appConfig`.
  AppConfig? _appConfig;

  // A string to remember where our friend lives online, `_baseUrl`.
  String? _baseUrl;

  // When we create our HTTpService helper, we want to check our magic cupboard for the AppConfig.
  HTTpService() {
    // We grab the AppConfig from the magic cupboard (GetIt).
    _appConfig = GetIt.instance.get<AppConfig>();
    // From that box, we pull out the friend's address (COIN_API_BASE_URL).
    _baseUrl = _appConfig?.COIN_API_BASE_URL;
  }

  // Now let’s write a letter (make an HTTP GET request) and send it.
  Future<Response?> get(String _path) async {
    try {
      // Combine our friend's address and the path we want to send the letter to.
      String _url = '$_baseUrl$_path';

      // Send the letter (HTTP GET request) using our mailman.
      Response _response = await dio.get(_url);

      // When the reply (response) arrives, we give it back.
      return _response;
    } catch (e) {
      // Uh-oh! If something goes wrong, let’s cry out loud and say what the problem is.
      print('HTTP GET Request Error: ');
      print(e);
    }
  }
}

