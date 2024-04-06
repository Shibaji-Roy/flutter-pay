import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:primo_pay/card_ui.dart';
import 'package:primo_pay/satispay_intent.dart';
import 'package:primo_pay/viva_details.dart';

class Method {
  //final String name;
  final Widget imageLogo;
  final Widget descriptionWidget;

  Method(this.imageLogo, this.descriptionWidget);
}

class PayOption extends StatefulWidget {
  const PayOption({Key? key}) : super(key: key);

  @override
  State<PayOption> createState() => _PayOption();
}

class _PayOption extends State<PayOption> {
  List<Method> methods = [
    Method(
      //'Lion',
      Image.network(
          'https://developer.vivawallet.com/images/pay-with-viva-wallet-logo.png'),
      VivaDetails(),
    ),
    Method(
      //'Tiger',
      SvgPicture.network(
          'https://demo.vivapayments.com/web2/img/card.326c3493.svg'),
      CardForm(),
    ),
    Method(
      //'Elephant',
      Image.asset('assets/icons/logo-RGB-web.jpg'),
      SatispaySelector(),
    ),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        //mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Pay with',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 75, 75, 75),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(color: Colors.white12),
            height: 55,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: methods.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    width: 130,
                    //height: 100,
                    child: Container(
                      height: 50,
                      width: 50,
                      child: methods[index].imageLogo,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          //Container(
          //  height: 350,
          //  child: SingleChildScrollView(
          //    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          //    reverse: true,
          //    child: Container(
          //        height: 510, child: methods[selectedIndex].descriptionWidget),
          //  ),
          //),
          Container(
            height: 350,
            child: Container(
                height: 350, child: methods[selectedIndex].descriptionWidget),
          ),
        ],
      ),
    );
  }
}
