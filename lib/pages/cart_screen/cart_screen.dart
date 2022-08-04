import 'package:cashair/layout/cubit/shop_cubit.dart';
import 'package:cashair/layout/cubit/shop_states.dart';
import 'package:cashair/models/add_cart_model.dart';
import 'package:cashair/models/cart_model.dart';
import 'package:cashair/pages/payment_screen/payment_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class CartScreen extends StatelessWidget {
  final Cart? model;

  const CartScreen(this.model);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                foregroundColor: Colors.white,
                child: Icon(Icons.keyboard_arrow_down_rounded),
              ),
            ),
            title: Text(
              'Cart',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          body: ConditionalBuilder(
            condition: model != null,
            builder: (context) => cartView(model!, context),
            fallback: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.line_weight_sharp,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'No Cart Info yet please add one',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageTransition(
                  child: PaymentScreen(model!.totalPrice.toString()),
                  type: PageTransitionType.leftToRight,
                ),
              );
            },
            backgroundColor: Theme.of(context).primaryColor,
            label: Text('CHECKOUT'),
            icon: Icon(Icons.monetization_on_outlined),
          ),
        );
      },
    );
  }

  cartView(Cart model, BuildContext ctx) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 30,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 1),
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 2,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Theme.of(ctx).accentColor,
                  foregroundColor: Colors.white,
                  child: Icon(Icons.shopping_cart, size: 60),
                ),
                SizedBox(width: 20),
                Column(
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(ctx).accentColor,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '${model.totalPrice}  LE',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          ConditionalBuilder(
            condition: model.products.length > 0,
            builder: (context) => productsBuilder(model.products, context),
            fallback: (context) => Center(
              child: Text('No products yet'),
            ),
          ),
        ],
      ),
    );
  }

  Widget productsBuilder(List<Products> products, BuildContext ctx) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (ctx, index) => productItem(products[index], ctx),
      separatorBuilder: (ctx, index) => SizedBox(height: 10),
      itemCount: products.length,
    );
  }

  Widget productItem(Products product, BuildContext c) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            child: Image(
              fit: BoxFit.cover,
              image: NetworkImage(
                  'https://hypermarket-project.herokuapp.com${product.image}'),
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${product.name}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(c).accentColor,
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    'Price ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '${product.price}  LE',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Text(
            '${product.quantity}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
