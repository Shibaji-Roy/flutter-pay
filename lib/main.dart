import 'package:flutter/material.dart';
import 'package:primo_pay/payment_methods.dart';
import 'package:primo_pay/square01.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primo_pay/square02.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uni_links/uni_links.dart';

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

@riverpod
class MyError extends _$MyError {
  @override
  String build() {
    return "";
  }

  void update(String value) {
    state = value;
  }
}

void handleIncomingLinks(WidgetRef ref) {
  // Handle the link that opened the app
  getInitialLink().then((initialLink) {
    if (initialLink != null) {
      print("InitialLink:$initialLink");
      // Process the initial link
      ref.read(myErrorProvider.notifier).update(initialLink);
    }
  });

  // Listen for incoming links
  linkStream.listen((String? link) {
    if (link != null) {
      // Process the incoming link
      print("Link:$link");
    }
  }, onError: (err) {
    // Handle errors
    print("Error:$err");
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // handleIncomingLinks();
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
    handleIncomingLinks(ref);
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
