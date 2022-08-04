import 'package:cashair/pages/login_screen/login_screen.dart';
import 'package:cashair/pages/register_screen/cubit/register_cubit.dart';
import 'package:cashair/pages/register_screen/cubit/register_states.dart';
import 'package:cashair/shared/components/components.dart';
import 'package:cashair/shared/constants.dart';
import 'package:cashair/shared/network/local/cash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:page_transition/page_transition.dart';

class RegisterScreen extends StatelessWidget {
  var registerFormKey = GlobalKey<FormState>();
  var registerNameController = TextEditingController();
  var registerUserNameController = TextEditingController();
  var registerPasswordController = TextEditingController();
  var registerPasswordControllerConfirm = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.registerModel.success) {
              CashHelper.putData(
                  key: 'userName', value: '${registerNameController.text}');
              CashHelper.putData(
                  key: 'userId', value: '${registerUserNameController.text}');
              CashHelper.putData(
                  key: 'phone', value: '${phoneController.text}');
              FlutterToastr.show('Account created successfully', context);
              Navigator.pushReplacement(
                context,
                PageTransition(
                  child: LoginScreen(),
                  type: PageTransitionType.bottomToTop,
                ),
              );
            }
            else{
              FlutterToastr.show('register error', context);
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopRegisterCubit.get(context);
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
              child: Center(
                child: Form(
                  key: registerFormKey,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SING UP',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'BE ONE OF THE FAMILY',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 20),
                          textInput(
                            prefixIcon: Icon(Icons.person_rounded),
                            label: 'User Name',
                            controller: registerNameController,
                            errorMessage: 'User Name is required',
                            errorColor: Theme.of(context).primaryColor,
                          ),
                          SizedBox(height: 20),
                          textInput(
                            prefixIcon: Icon(Icons.email),
                            label: 'userName or Email',
                            controller: registerUserNameController,
                            errorMessage: 'User Name is required',
                            errorColor: Theme.of(context).primaryColor,
                          ),
                          SizedBox(height: 20),
                          textInput(
                            prefixIcon: Icon(Icons.phone),
                            keyboardType: TextInputType.phone,
                            label: 'Phone',
                            controller: phoneController,
                            errorMessage: 'User Name is required',
                            errorColor: Theme.of(context).primaryColor,
                          ),
                          SizedBox(height: 20),
                          textInput(
                            label: 'Password',
                            controller: registerPasswordController,
                            errorMessage: 'Password is required',
                            obscureText: cubit.obsecured,
                            keyboardType: TextInputType.visiblePassword,
                            errorColor: Theme.of(context).primaryColor,
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                ShopRegisterCubit.get(context)
                                    .changeVisibility();
                              },
                              icon: Icon(ShopRegisterCubit.get(context).suf),
                            ),
                          ),
                          SizedBox(height: 20),
                          textInput(
                            label: 'Confirm Password',
                            controller: registerPasswordControllerConfirm,
                            errorMessage: 'Confirm Password is required',
                            obscureText: cubit.obsecured,
                            keyboardType: TextInputType.visiblePassword,
                            errorColor: Theme.of(context).primaryColor,
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                ShopRegisterCubit.get(context)
                                    .changeVisibility();
                              },
                              icon: Icon(ShopRegisterCubit.get(context).suf),
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: MaterialButton(
                              onPressed: () {
                                if (registerFormKey.currentState!.validate() &&
                                    registerPasswordController.text ==
                                        registerPasswordControllerConfirm
                                            .text) {
                                  cubit.userRegister(
                                    name: registerNameController.text,
                                    userName: registerUserNameController.text,
                                    password: registerPasswordController.text,
                                  );
                                }
                              },
                              child: Text(
                                'SIGN UP',
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
                          )
                        ],
                      ),
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
