import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:primo_pay/card_ui.dart';
import 'package:primo_pay/satispay_intent.dart';
import 'package:primo_pay/viva_wallet_intent.dart';

class PayOption extends StatefulWidget {
  const PayOption({super.key});
  @override
  State<PayOption> createState() => _PayOptionState();
}

class _PayOptionState extends State<PayOption> {
  @override
  Widget build(BuildContext context) {
    final paymentMethods = [
      Image.network(
          'https://developer.vivawallet.com/images/pay-with-viva-wallet-logo.png'),
      SvgPicture.network(
          'https://demo.vivapayments.com/web2/img/card.326c3493.svg'),
      Image.asset('assets/icons/logo-RGB-web.jpg')
      // Add more images as needed
    ];
    return Padding(
      padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0), // Adjust padding as needed
              child: Text(
                'pay with',
                style: TextStyle(
                  fontSize: 16.0, // Adjust font size as needed
                  // Add other text styling properties if required
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 60,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: paymentMethods.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            switch (index) {
                              case 0:
                                // Handle tap for the first payment method
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const Dialog(
                                      child:
                                          VivaWalletSelector(), // Show the SatispaySelector widget as a dialog
                                    );
                                  },
                                );
                                break;
                              case 1:
                                // Handle tap for the second payment method
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const Dialog(
                                      child:
                                          CardForm(), // Show the PaymentForm widget as a dialog
                                    );
                                  },
                                );
                                print('Second payment method tapped');
                                break;
                              case 2:
                                // Handle tap for the Satispay button
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const Dialog(
                                      child:
                                          SatispaySelector(), // Show the SatispaySelector widget as a dialog
                                    );
                                  },
                                );
                                break;
                              // Add more cases for additional payment methods as needed
                            }
                          },
                          child: Container(
                            width: 110, // Width of your buttons
                            margin: const EdgeInsets.symmetric(
                                horizontal: 2.0), // Spacing between buttons
                            child: paymentMethods[index],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
