//import 'dart:html';

import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter/material.dart';
import 'package:primo_pay/mqtt_service.dart';
import 'package:primo_pay/viva_button.dart';

class VivaDetails extends StatefulWidget {
  const VivaDetails({super.key});

  @override
  State<VivaDetails> createState() => _VivaDetailsState();
}

class _VivaDetailsState extends State<VivaDetails> {
  final MQTTClientWrapper mqttClientWrapper = MQTTClientWrapper();

  final _formKey = GlobalKey<FormState>();
  String emailAddress = '';
  String cardHolderName = '';
  String description = '';
  bool rememberCard = false;

  void _launchActivity() {
    final intent = AndroidIntent(
      action: "action_view",
      data: Uri(
        scheme: 'vivapayclient',
        host: 'pay',
        path: 'v1',
        queryParameters: {
          'appId': 'com.example.primo_pay',
          'action': 'activatePos',
          'apikey': 'qwerty123456',
          'apiSecret': 'qwerty123456',
          'sourceID': 'qwerty123456',
          'pinCode': '123142',
          'skipExternalDeviceSetup': 'true',
          'activateMoto': 'true',
          'activateQRCodes': 'true',
          'disableManualAmountEntry': 'true',
          'forceCardPresentmentForRefund': 'true',
          'lockRefund': 'true',
          'lockTransactionsList': 'true',
          'lockMoto': 'true',
          'lockPreauth': 'true',
          'callback': 'mycallbackscheme://result',
        },
      ).toString(),
      flags: [
        Flag.FLAG_ACTIVITY_NEW_TASK,
        Flag.FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS,
      ],
    );
    intent.launch();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 150,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          primary: true,
          padding: EdgeInsets.all(20),
          child: Container(
            height: 274,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    height: 40,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        prefixIcon: Icon(Icons.email),
                      ),
                      onSaved: (value) => emailAddress = value ?? '',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    height: 40,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Cardholder Name',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        prefixIcon: Icon(Icons.person),
                      ),
                      onSaved: (value) => cardHolderName = value ?? '',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        prefixIcon: Icon(Icons.credit_card),
                      ),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      onSaved: (value) => description = value ?? '',
                    ),
                  ),
                  const SizedBox(height: 1),
                  CheckboxListTile(
                    title: const Text('Remember this card'),
                    value: rememberCard,
                    onChanged: (bool? value) {
                      setState(() {
                        rememberCard = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  const SizedBox(height: 1),
                  ElevatedButton(
                    onPressed: () {
                      _submitForm();
                      _launchActivity();
                      // mqttClientWrapper.prepareMqttClient();
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(400, 50),
                      backgroundColor:
                          Color.fromRGBO(77, 169, 190, 10), // Background color
                      foregroundColor: Colors.white, // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                      child: VivaButton(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Process the form data
      print('Email: $emailAddress');
      print('Cardholder Name: $cardHolderName');
      print('Card Number: $description');
      print('Remember Card: $rememberCard');
    }
  }
}
