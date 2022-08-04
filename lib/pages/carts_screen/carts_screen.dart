import 'package:cashair/layout/cubit/shop_cubit.dart';
import 'package:cashair/layout/cubit/shop_states.dart';
import 'package:cashair/models/get_carts_model.dart';
import 'package:cashair/pages/cart_screen/cart_screen-2.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class CartsScreen extends StatelessWidget {
  final List<Carts> cartsList ;

  const CartsScreen(this.cartsList);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                foregroundColor: Colors.white,
                child: Icon(Icons.arrow_back_ios_outlined),
              ),
            ),
          ),
          body: SafeArea(
            child: ConditionalBuilder(
              condition: cartsList.length > 0,
              builder: (context) =>
                  cartsLayout(cartsList, context),
              fallback: (context) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.line_style,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'No Carts yet',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget cartsLayout(List<Carts> carts, BuildContext ctx) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      itemBuilder: (context, index) => cartItem(carts[index], ctx, index),
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemCount: carts.length,
    );
  }

  Widget cartItem(Carts model, BuildContext c, int i) {
    return InkWell(
      onTap: () {
        Navigator.push(
          c,
          PageTransition(
            child: CartScreen2(model),
            type: PageTransitionType.rightToLeft,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
              backgroundColor: Theme.of(c).accentColor,
              foregroundColor: Colors.white,
              child: Icon(Icons.shopping_cart),
            ),
            SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cart ${i + 1}',
                  style: TextStyle(
                    color: Theme.of(c).accentColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '${model.createdAt}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 17,
                    //fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
