import 'dart:io';
import 'package:flutter/material.dart';
import 'package:android_intent_plus/android_intent.dart';

class SatispaySelector extends StatelessWidget {
  const SatispaySelector({super.key});

  Future<void> _launchActivity(String package, String data, context) async {
    if (Platform.isAndroid) {
      final AndroidIntent intent = AndroidIntent(
        action: 'action_view',
        package: package,
        data: data,
      );
      try {
        await intent.launch();
      } catch (err) {
        showDialog(
          context: context, // You need to pass the BuildContext here
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: Text(
                  "An error occurred: $err"), // Displaying the error message
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop(); // Dismiss the dialog
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: 350,
        color: const Color.fromARGB(149, 226, 232, 232),
        child: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => _launchActivity(
                  'com.satispay.customer',
                  Uri.parse('satispay:').toString(),
                  context,
                ),
                child: const Text('Open Satispay'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _launchActivity(
                  'com.satispay.customer',
                  Uri.parse(
                          'https://play.google.com/store/apps/details?id=com.satispay.customer')
                      .toString(),
                  context,
                ),
                child: const Text('Download Satispay'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
