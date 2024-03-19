import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:primo_pay/card_ui.dart';
import 'package:primo_pay/main.dart';
import 'package:primo_pay/satispay_intent.dart';
import 'package:primo_pay/viva_wallet_intent.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentScreen extends ConsumerWidget {
  const PaymentScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentMethods = [
      Image.network(
          'https://developer.vivawallet.com/images/pay-with-viva-wallet-logo.png'),
      SvgPicture.network(
          'https://demo.vivapayments.com/web2/img/card.326c3493.svg'),
      Image.asset('assets/icons/logo-RGB-web.jpg')
      // Add more images as needed
    ];
    //final Uri url = Uri.parse('https://flutter.dev');
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            SvgPicture.asset('assets/svg/logo-no-background (1).svg',
                height: 150, width: 158),

            const SizedBox(height: 20),
            const Text(
              'Online Payment Service',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  prefixIcon: Icon(Icons.euro_symbol),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (String value) =>
                    {ref.watch(myTextProvider.notifier).update(value)},
              ),
            ),
            const SizedBox(
              height: 16,
            ),
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
            SizedBox(
              height: 58, // Height of your buttons
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
            Container(
              padding: const EdgeInsets.all(8.0), // Adjust padding as needed
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .stretch, // Make the button fill the width
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.only(top: 12.0), // Adjust padding as needed
                    child: Text(
                      'Log in to your viva.com account to complete your purchase securely',
                      style: TextStyle(
                        fontSize: 16.0, // Adjust font size as needed
                        // Add other text styling properties if required
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0), // Adjust spacing as needed
                  ElevatedButton(
                    onPressed: () async {
                      final Uri url =
                          Uri.parse('https://demo.vivapayments.com/en/signup');
                      if (!await launchUrl(url)) {
                        throw 'Could not launch $url';
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.blue, // Adjust button color as needed
                      padding: const EdgeInsets.all(
                          12.0), // Adjust padding as needed
                      textStyle: const TextStyle(
                        fontSize: 20.0, // Adjust font size as needed
                        fontWeight:
                            FontWeight.w600, // Adjust font weight as needed
                      ),
                    ),
                    child: const Text(
                      'Continue to viva.com',
                      style: TextStyle(
                        color: Color.fromARGB(
                            255, 255, 255, 255), // Set your desired color here
                        // Add other text styling properties if required
                      ),
                    ),
                  ),
                ],
              ),
            )

            // ... add other elements as needed
          ],
        ),
      ),
    );
  }
}
