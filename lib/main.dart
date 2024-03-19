import 'package:flutter/material.dart';
import 'package:primo_pay/payment_methods.dart';
import 'package:primo_pay/squre(1).dart';
//import 'package:primo_pay/android_intent.dart';
//import 'package:primo_pay/ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primo_pay/squre(2).dart';
//import 'package:primo_pay/squre(3).dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main.g.dart';

@riverpod
class MyText extends _$MyText {
  @override
  String build() {
    return "";
  }

  void update(String value) {
    state = value;
  }
}

void main() {
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'PrimoPay',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        //appBar: AppBar(
        //  title: Text("Primo Pay"),
        //  actions: [
        //    IconButton(
        //      icon: const Icon(Icons.language),
        //      onPressed: () {
        //        // Handle language change
        //      },
        //    ),
        //  ],
        //),
        body: Container(
          color: Color.fromARGB(255, 209, 216, 216),
          child: Column(
            children: const [MySquare(), PayBar(), PayOption()],
          ),
        ),
      ),
    );
  }
}
