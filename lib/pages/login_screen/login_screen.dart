import 'package:cashair/layout/layout.dart';
import 'package:cashair/pages/login_screen/cubit/login_cubit.dart';
import 'package:cashair/pages/login_screen/cubit/login_states.dart';
import 'package:cashair/pages/register_screen/register_screen.dart';
import 'package:cashair/shared/components/components.dart';
import 'package:cashair/shared/constants.dart';
import 'package:cashair/shared/network/local/cash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.success) {
              CashHelper.putData(key: 'token', value: state.loginModel.token);
              token = state.loginModel.token;
              FlutterToastr.show('Successfully login', context);
              Navigator.pushReplacement(
                context,
                PageTransition(
                  child: Home(),
                  type: PageTransitionType.leftToRight,
                ),
              );
            }
            else{
              FlutterToastr.show('Login error', context);
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopLoginCubit.get(context);
          return Scaffold(
            body: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image(
                            height: 250,
                            width: 250,
                            image: AssetImage('assets/images/p1.png'),
                          ),
                        ),
                        Text(
                          'SING IN',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'ALL YOUR NEEDS HERE',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 40),
                        textInput(
                            prefixIcon: Icon(Icons.person_rounded),
                            label: 'User Name',
                            controller: userNameController,
                            errorMessage: 'User Name is required',
                            errorColor: Theme.of(context).primaryColor),
                        SizedBox(height: 20),
                        textInput(
                          label: 'Password',
                          controller: passwordController,
                          errorMessage: 'Password is required',
                          obscureText: cubit.obsecured,
                          keyboardType: TextInputType.visiblePassword,
                          errorColor: Theme.of(context).primaryColor,
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              ShopLoginCubit.get(context).changeVisibility();
                            },
                            icon: Icon(ShopLoginCubit.get(context).suf),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: MaterialButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userLogin(
                                  userName: userNameController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            child: Text(
                              'SIGN IN',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            color: Theme.of(context).primaryColor,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        SizedBox(height: 80),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                'Don\'t hava account',
                                style: TextStyle(
                                  color: Colors.grey,
                                  //fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              //SizedBox(height: 5),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      child: RegisterScreen(),
                                      type: PageTransitionType.leftToRight,
                                    ),
                                  );
                                },
                                child: Text(
                                  'CREATE NOW',
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
