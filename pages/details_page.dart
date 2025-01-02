import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  // Imagine this page as a treasure map where you see all the exchange rates for your favorite coin!

  final Map
      rates; // This is like a box filled with exchange rates for different currencies.

  // We give this page the box (rates) when we open it.
  const DetailsPage({required this.rates});

  @override
  Widget build(BuildContext context) {
    // First, we unpack the box (rates) to get the list of currencies and their exchange rates.
    List _currencies = rates.keys
        .toList(); // These are the names of the currencies (like USD, EUR).
    List _exchangeRates =
        rates.values.toList(); // These are their exchange rates (numbers).

    // Now, we create the big treasure map (the page) with a list showing all the exchange rates.
    return Scaffold(
        body: SafeArea(
      // We keep everything safe and tidy with SafeArea so nothing gets hidden behind the phone's notch.
      child: ListView.builder(
        // Our list will have one item for every currency.
        itemCount: _currencies
            .length, // The total number of treasures (currencies) to show.
        itemBuilder: (_context, _index) {
          // For each item in the list, we find the currency name and its exchange rate.
          String _currency = _currencies[_index].toString().toUpperCase();
          // We make the currency name all big and loud (uppercase), so it looks important!

          String _exchangerate = _exchangeRates[_index].toString();
          // The exchange rate is the treasure chest, a shiny number for each currency.

          // Now we design a row (ListTile) to show both the currency and its exchange rate together.
          return ListTile(
            // The title of each row is a big label showing the currency and its treasure (exchange rate).
            title: Text(
              "$_currency : $_exchangerate", // Looks like "USD : 1.0" or "EUR : 0.89".
              style: TextStyle(
                  color: Colors
                      .white), // White text to look clean and easy to read.
            ),
          );
        },
      ),
    ));
  }
}
