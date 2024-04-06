import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primo_pay/main.dart';

class VivaButton extends ConsumerWidget {
  final String currency;

//PayButton({required this.amount});

  const VivaButton({super.key, this.currency = '€'});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text.rich(
      TextSpan(
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        children: [
          const TextSpan(text: 'Pay '),
          TextSpan(
            text: currency,
            style: const TextStyle(color: Color.fromARGB(202, 234, 234, 234)),
          ),
          TextSpan(
            text: ' ${ref.watch(myTextProvider)}',
            style: const TextStyle(textBaseline: TextBaseline.alphabetic),
          ),
        ],
      ),
    );
  }
}
