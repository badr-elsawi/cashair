import 'package:cashair/models/login_model.dart';
import 'package:cashair/shared/constants.dart';
import 'package:cashair/shared/network/remote/dio_helper.dart';
import 'package:cashair/shared/network/remote/end_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'login_states.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginIntialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  IconData suf = Icons.visibility_off_rounded;
  bool obsecured = true;

  void changeVisibility() {
    suf = obsecured ? Icons.visibility_rounded : Icons.visibility_off_rounded;
    obsecured = !obsecured;
    emit(ChangePasswordState());
  }

  //*******************************************
  late LoginModel loginModel;

  //*******************************************

  void userLogin({
    required String userName,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'username': userName,
      'password': password,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print("**************************************");
      print("**************************************");
      print(loginModel.token);
      print("**************************************");
      print("**************************************");
      emit(ShopLoginSuccessState(loginModel));
      token = loginModel.token;
    }).catchError((error) {
      print(error);
      emit(ShopLoginErrorState(error.toString()));
    });
  }
}
