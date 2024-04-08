import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primo_pay/main.dart';

class PayBar extends ConsumerWidget {
  const PayBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
      child: Container(
        height: 120,
        width: double.infinity,
        color: Color.fromRGBO(56, 125, 141, 10),
        child: Column(
          children: [
            SizedBox(height: 10),
            const Text(
              'Online Payment Services',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                style: TextStyle(color: Color.fromRGBO(249, 252, 252, 10)),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xF64DA9BE),
                    labelText: 'Amount',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(251, 252, 252, 10)),
                    prefixIcon: Icon(Icons.euro_symbol),
                    prefixIconColor: Color.fromRGBO(214, 220, 221, 10)),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (String value) =>
                    {ref.read(myTextProvider.notifier).update(value)},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
