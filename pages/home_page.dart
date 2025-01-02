// Imagine we're creating a magic screen (app) where you can see fun details about coins like Bitcoin and Ethereum!
// This app has a homepage where all the magic happens.

import 'dart:convert';
// This helps us read secret messages (data) written in a special code called JSON.

import 'dart:math';
// Math helps us do tricky calculations when needed!

import 'package:flutter/material.dart';
// Flutter is our toolkit to build the screen where the magic appears.

import 'package:flutter_application_1/pages/details_page.dart';
// This brings in a special page that shows extra details about the coins.

import 'package:flutter_application_1/service/http_service.dart';
// Our helper from before (HTTpService) is brought in to talk to the internet.

import 'package:get_it/get_it.dart';
// Our magic cupboard (GetIt) helps us keep and grab tools like HTTpService whenever needed.

class MyHomepage extends StatefulWidget {
  @override
  State<MyHomepage> createState() => _HomepageState();
}

// Now we build the main part of our magic screen!
class _HomepageState extends State<MyHomepage> {
  // First, we measure the width and height of the device to set things up nicely.
  double? _deviceWidth;
  double? _deviceHeight;

  // Here, we pick our favorite coin (like choosing your favorite candy). Let's start with Bitcoin.
  String? _selectedcoin = "bitcoin";

  // We also create a helper (_http) to send and receive messages about the coins.
  HTTpService? _http;

  @override
  void initState() {
    super.initState();
    // Here, we open our magic cupboard to grab the helper (HTTpService).
    _http = GetIt.instance.get<HTTpService>();
  }

  @override
  Widget build(BuildContext context) {
    // We find out the screen's width and height to make our screen look perfect.
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;

    // This Scaffold is the big frame where all the fun stuff happens.
    return Scaffold(
      body: SafeArea(
        // We make everything centered so it's nice and organized.
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            // Here, we show two fun widgets: one to pick a coin and the other to show coin details!
            children: [_SelectedCoinDropdown(), _dataWidgets()],
          ),
        ),
      ),
    );
  }

  // Let's make a magical dropdown where we can choose which coin to see.
  Widget _SelectedCoinDropdown() {
    // These are the names of the shiny coins we can choose from.
    List<String> _coins = ["bitcoin", "ethereum", "tether", "cardano"];

    // For each coin, we create a little button (menu item) with its name.
    List<DropdownMenuItem<String>> _items = _coins
        .map(
          (e) => DropdownMenuItem(
            value: e,
            child: Text(
              e,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )
        .toList();

    return DropdownButton(
      // The chosen coin (e.g., Bitcoin) is shown here.
      value: _selectedcoin,
      items: _items,
      // When we pick a different coin, this updates the screen.
      onChanged: (dynamic _value) {
        setState(() {
          _selectedcoin = _value;
        });
      },
      dropdownColor: Colors.green, // Background for the dropdown.
      iconSize: 30, // The size of the arrow icon.
      icon: const Icon(Icons.arrow_drop_down_sharp, color: Colors.white),
      underline: Container(), // Hides the boring line under the dropdown.
    );
  }

  // Here’s the part that shows the details of the chosen coin.
  Widget _dataWidgets() {
    // We fetch coin details from the internet using our helper (_http).
    return FutureBuilder(
        future: _http?.get('/coins/$_selectedcoin'),
        builder: (BuildContext context, AsyncSnapshot _snapshot) {
          if (_snapshot.hasData) {
            // When the data arrives, we decode it (like opening a sealed letter).
            Map _data = jsonDecode(
              _snapshot.data.toString(),
            );

            // Let's grab some shiny details about the coin, like its price and change percentage.
            num _usdPrice = _data['market_data']['current_price']['usd'];
            num _percentageChange =
                _data['market_data']['price_change_percentage_24h'];
            Map _exchangeRates = _data['market_data']['current_price'];

            // Now we create fun widgets to show the details!
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // When you double-tap the coin image, you go to the details page.
                GestureDetector(
                  onDoubleTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext _context) {
                        return DetailsPage(rates: _exchangeRates);
                      }),
                    );
                  },
                  // Show the coin’s picture.
                  child: _coinimagewidget(_data["image"]["large"]),
                ),
                // Show the current price.
                _currentpricewidget(_usdPrice),
                // Show the percentage change.
                percentagechangewidet(_percentageChange),
                // Show a little description about the coin.
                _DescriptionWidget(_data['description']['en']),
              ],
            );
          } else {
            // If the data is still loading, we show a spinning circle.
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
        });
  }

  // This widget shows the current price of the coin in USD.
  Widget _currentpricewidget(num _rate) {
    return Text(
      "${_rate.toStringAsFixed(2)}USD",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 40,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  // This widget shows the price change in percentage.
  Widget percentagechangewidet(num _change) {
    return Text(
      "${_change.toString()}%",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 40,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  // This widget shows a nice picture of the coin.
  Widget _coinimagewidget(String _imgURL) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.02),
      height: _deviceHeight! * 0.15,
      width: _deviceWidth! * 0.15,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(_imgURL),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // This widget shows a box with a short story (description) about the coin.
  Widget _DescriptionWidget(String _description) {
    return Container(
      width: _deviceWidth! * 0.90,
      height: _deviceHeight! * 0.45,
      margin: EdgeInsets.symmetric(
        vertical: _deviceHeight! * 0.05,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: _deviceWidth! * 0.01,
        vertical: _deviceHeight! * 0.01,
      ),
      color: Colors.blueGrey, // Background color for the box.
      child: Text(
        _description,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}

