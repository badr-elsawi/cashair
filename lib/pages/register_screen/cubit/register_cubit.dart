import 'package:cashair/models/login_model.dart';
import 'package:cashair/models/register_model.dart';
import 'package:cashair/pages/register_screen/cubit/register_states.dart';
import 'package:cashair/shared/constants.dart';
import 'package:cashair/shared/network/remote/dio_helper.dart';
import 'package:cashair/shared/network/remote/end_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';



class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  IconData suf = Icons.visibility_off_rounded;
  bool obsecured = true;

  void changeVisibility() {
    suf = obsecured ? Icons.visibility_rounded : Icons.visibility_off_rounded;
    obsecured = !obsecured;
    emit(ChangePasswordState());
  }

  //*******************************************
  late RegisterModel registerModel;

  //*******************************************

  void userRegister({
    required String name,
    required String userName,
    required String password,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'username': userName,
      'password': password,
    }).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      print("**************************************");
      print("**************************************");
      print(registerModel.status);
      print("**************************************");
      print("**************************************");
      emit(ShopRegisterSuccessState(registerModel));
    }).catchError((error) {
      print(error);
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
}
