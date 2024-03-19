import 'package:flutter/material.dart';
import 'package:primo_pay/paybutton.dart';

class CardForm extends StatefulWidget {
  const CardForm({super.key});

  @override
  State<CardForm> createState() => _CardFormState();
}

class _CardFormState extends State<CardForm> {
  final _formKey = GlobalKey<FormState>();
  String emailAddress = '';
  String cardHolderName = '';
  String cardNumber = '';
  String cardExpiration = '';
  String cvv = '';
  bool rememberCard = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: SingleChildScrollView(
        reverse: true,
        physics: BouncingScrollPhysics(),
        child: Container(
          height: 510,
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
                          borderRadius: BorderRadius.all(Radius.circular(10))),
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
                          borderRadius: BorderRadius.all(Radius.circular(10))),
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
                      labelText: 'Card Number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      prefixIcon: Icon(Icons.credit_card),
                    ),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    onSaved: (value) => cardNumber = value ?? '',
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Expiration Date',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            prefixIcon: Icon(Icons.date_range),
                          ),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          onSaved: (value) => cardExpiration = value ?? '',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'CVV',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            prefixIcon: Icon(Icons.lock),
                          ),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          onSaved: (value) => cvv = value ?? '',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
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
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(400, 50),
                    backgroundColor: Colors.blue, // Background color
                    foregroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                    child: PayButton(),
                  ),
                ),
              ],
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
      print('Card Number: $cardNumber');
      print('Expiration Date: $cardExpiration');
      print('CVV: $cvv');
      print('Remember Card: $rememberCard');
    }
  }
}
