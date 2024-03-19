import 'dart:io';
import 'package:flutter/material.dart';
import 'package:android_intent_plus/android_intent.dart';
//import 'package:url_launcher/url_launcher.dart';

class VivaWalletSelector extends StatelessWidget {
  const VivaWalletSelector({super.key});

  Future<void> _launchActivity(
      String package, String componentName, context) async {
    if (Platform.isAndroid) {
      final AndroidIntent intent = AndroidIntent(
        action: 'action_view',
        package: package,
        componentName: componentName,
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
        color: Color.fromARGB(149, 226, 232, 232),
        child: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => _launchActivity(
                  'com.vivawallet.business',
                  'com.vivawallet.business.features.start',
                  context,
                ),
                child: const Text('viva.com | Terminal'),
              ),
              //const SizedBox(height: 20),
              //ElevatedButton(
              //  onPressed: () => _launchActivity(
              //    'com.vivawallet.spoc.payapp.demo',
              //    'com.vivawallet.spoc.payapp.demo.features.splash.view.SplashActivity',
              //    context,
              //  ),
              //  child: const Text('Viva.com | Terminal DEMO'),
              //),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
