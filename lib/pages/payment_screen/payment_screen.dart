import 'package:cashair/layout/cubit/shop_cubit.dart';
import 'package:cashair/layout/cubit/shop_states.dart';
import 'package:cashair/layout/layout.dart';
import 'package:cashair/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class PaymentScreen extends StatelessWidget {
  final String total;

  PaymentScreen(this.total);

  var cardNumber = TextEditingController();
  var price = TextEditingController();
  var year = TextEditingController();
  var month = TextEditingController();
  var cvv = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        price.text = 'price $total LE';
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    child: Home(),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
              icon: CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                foregroundColor: Colors.white,
                child: Icon(Icons.arrow_back_ios_outlined),
              ),
            ),
            title: Text(
              'Card information',
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      textInput(
                        label: 'total',
                        controller: price,
                        errorMessage: 'card number is required',
                        errorColor: Theme.of(context).primaryColor,
                      ),
                      SizedBox(height: 10),
                      textInput(
                        label: 'Card Number',
                        controller: cardNumber,
                        errorMessage: 'card number is required',
                        errorColor: Theme.of(context).primaryColor,
                      ),
                      SizedBox(height: 10),
                      textInput(
                        label: 'CVV',
                        controller: cardNumber,
                        errorMessage: 'required',
                        errorColor: Theme.of(context).primaryColor,
                      ),
                      SizedBox(height: 20),
                      Text('Expiry Dte'),
                      SizedBox(height: 20),
                      textInput(
                        label: 'YY',
                        controller: year,
                        errorMessage: 'required',
                        errorColor: Theme.of(context).primaryColor,
                      ),
                      SizedBox(height: 10),
                      textInput(
                        label: 'MM',
                        controller: month,
                        errorMessage: 'required',
                        errorColor: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                cubit.pay(
                  cardNumber: cardNumber.text,
                  amount: price.text,
                  cvv: cvv.text,
                  expiryYear: year.text,
                  expiryMonth: month.text,
                );
              }
            },
            backgroundColor: Theme.of(context).primaryColor,
            label: Text('CHECKOUT'),
            icon: Icon(Icons.monetization_on_outlined),
          ),
        );
      },
    );
  }
}
