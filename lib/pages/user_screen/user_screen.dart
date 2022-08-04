import 'package:cashair/layout/cubit/shop_cubit.dart';
import 'package:cashair/layout/cubit/shop_states.dart';
import 'package:cashair/pages/login_screen/login_screen.dart';
import 'package:cashair/shared/components/components.dart';
import 'package:cashair/shared/constants.dart';
import 'package:cashair/shared/network/local/cash_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:page_transition/page_transition.dart';

class UserScreen extends StatelessWidget {
  var user_name = TextEditingController();
  var user_userName = TextEditingController();
  var user_phone = TextEditingController();
  var user_password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is LogoutSuccessState) {
          CashHelper.clearData(key: 'token').then((value) {
            Navigator.pushReplacement(
              context,
              PageTransition(
                child: LoginScreen(),
                type: PageTransitionType.bottomToTop,
              ),
            );
            FlutterToastr.show('${state.model.status}', context);
          });
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        user_name.text = name;
        user_userName.text = userName;
        user_password.text = password;
        user_phone.text = phone;
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
            title: Text('${user_name.text}'),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextButton(
                  onPressed: () {
                    cubit.logout();
                  },
                  child: Text(
                    'LOGOUT',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                              backgroundColor: Theme.of(context).accentColor,
                              foregroundColor: Colors.white,
                              child: Icon(Icons.person, size: 60),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${user_name.text}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.email,
                                        color: Theme.of(context).accentColor,
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          '${user_userName.text}',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: Theme.of(context).accentColor,
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          '${user_phone.text}',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 5),
                      textInput(
                        prefixIcon: Icon(Icons.person_rounded),
                        label: 'User Name',
                        controller: user_name,
                        errorMessage: 'User Name is required',
                        errorColor: Theme.of(context).primaryColor,
                      ),
                      SizedBox(height: 20),
                      textInput(
                        prefixIcon: Icon(Icons.email),
                        label: 'User id',
                        controller: user_userName,
                        errorMessage: 'User Name is required',
                        errorColor: Theme.of(context).primaryColor,
                      ),
                      SizedBox(height: 20),
                      textInput(
                        prefixIcon: Icon(Icons.phone),
                        label: 'phone',
                        controller: user_phone,
                        errorMessage: 'phone is required',
                        errorColor: Theme.of(context).primaryColor,
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: MaterialButton(
                          onPressed: () {},
                          child: Text(
                            'UPDATE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          color: Theme.of(context).primaryColor,
                          padding:
                              EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
