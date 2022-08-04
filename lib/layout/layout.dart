import 'package:cashair/layout/cubit/shop_cubit.dart';
import 'package:cashair/layout/cubit/shop_states.dart';
import 'package:cashair/models/home_model.dart';
import 'package:cashair/models/product_model.dart';
import 'package:cashair/pages/cart_screen/cart_screen-2.dart';
import 'package:cashair/pages/cart_screen/cart_screen.dart';
import 'package:cashair/pages/carts_screen/carts_screen.dart';
import 'package:cashair/pages/payment_screen/payment_screen.dart';
import 'package:cashair/pages/user_screen/user_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

class Home extends StatelessWidget {

  String? qrCode;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is AddCartSuccessState) {
          Navigator.push(
            context,
            PageTransition(
              child: CartScreen(state.model.cart),
              type: PageTransitionType.bottomToTop,
              duration: Duration(milliseconds: 500),
            ),
          );
        }
        else if(state is GetCartSuccessState){
          Navigator.push(
            context,
            PageTransition(
              child: CartsScreen(state.model.carts),
              type: PageTransitionType.rightToLeft,
              duration: Duration(milliseconds: 500),
            ),
          );
        }
        else if(state is ShopGetUserState){
          Navigator.push(
            context,
            PageTransition(
              child: UserScreen(),
              type: PageTransitionType.bottomToTop,
              duration: Duration(milliseconds: 500),
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Home',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  cubit.getCarts();
                },
                icon: CircleAvatar(
                  backgroundColor: Theme.of(context).accentColor,
                  foregroundColor: Colors.white,
                  child: Icon(Icons.shopping_cart),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20, top: 0, bottom: 0),
                child: IconButton(
                  onPressed: () {
                    cubit.getUserInfo();
                  },
                  icon: CircleAvatar(
                    backgroundColor: Theme.of(context).accentColor,
                    foregroundColor: Colors.white,
                    child: Icon(Icons.person_rounded),
                  ),
                ),
              ),
            ],
          ),
          body: ConditionalBuilder(
            condition: cubit.homeModel != null,
            builder: (context) =>
                productsLayout(cubit.homeModel!.products, context),
            fallback: (context) => Center(
              child: CupertinoActivityIndicator(
                radius: 15,
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              qrCode = await FlutterBarcodeScanner.scanBarcode(
                '#ff6666',
                'Back',
                true,
                ScanMode.QR,
              );
              cubit.addCart(cartId: qrCode!);
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.qr_code_scanner),
          ),
        );
      },
    );
  }

//****************************************************************************
  Widget productsLayout(List<Products> products, BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SingleChildScrollView(
        child: GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 1 / 1.3,
          children: List.generate(products.length,
              (index) => productItem(products[index], ctx, index)),
        ),
      ),
    );
  }

  //****************************************************************************
//****************************************************************************************
  Widget productItem(Products model, BuildContext co, int i) {
    return Container(
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
          ]),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Center(
            child: SizedBox(
              height: 120,
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage('https://hypermarket-project.herokuapp.com${model.image}'),
              ),
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '${model.name}',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text(
                  '${model.price}  LE',
                  style: TextStyle(
                    fontSize: 18,
                    //fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: CircleAvatar(
                      backgroundColor: Theme.of(co).primaryColor,
                      foregroundColor: Colors.white,
                      child: Icon(Icons.favorite),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
//****************************************************************************
}
