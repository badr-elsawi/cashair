import 'package:bloc/bloc.dart';
import 'package:cashair/layout/cubit/shop_states.dart';
import 'package:cashair/models/add_cart_model.dart';
import 'package:cashair/models/get_carts_model.dart';
import 'package:cashair/models/home_model.dart';
import 'package:cashair/models/log_out_model.dart';
import 'package:cashair/shared/constants.dart';
import 'package:cashair/shared/network/local/cash_helper.dart';
import 'package:cashair/shared/network/remote/dio_helper.dart';
import 'package:cashair/shared/network/remote/end_points.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

//***********************************************
  void getUserInfo() async {
    var c1 = CashHelper.getString(key: 'userName');
    c1 == null ? name = '' : name = c1;
    var c2 = CashHelper.getString(key: 'userId');
    c2 == null ? userName = '' : userName = c2;
    var c3 = CashHelper.getString(key: 'phone');
    c3 == null ? phone = '' : phone = c3;
    emit(ShopGetUserState());
  }

//***********************************************




//***********************************************

  HomeModel? homeModel;

  void getProducts() {
    emit(HomeLoadingState());
    DioHelper.getData(url: PRODUCTS).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      emit(HomeSuccessState(homeModel!));
    }).catchError((error) {
      emit(HomeErrorState());
    });
  }

//***********************************************
//***********************************************
  GetCartsModel? getCartsModel;

  void getCarts() {
    emit(GetCartLoadingState());
    DioHelper.getData(
      url: GETCARTS,
      token: token!,
    ).then((value) {
      getCartsModel = GetCartsModel.fromJson(value.data);
      print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
      print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
      print(getCartsModel!.carts.toString());
      print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
      print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
      emit(GetCartSuccessState(getCartsModel!));
    }).catchError((error) {
      emit(GetCartErrorState());
    });
  }

//***********************************************
//***********************************************

  AddCartModel? addCartModel;

  void addCart({
    required String cartId,
  }) {
    emit(AddCartLoadingState());
    DioHelper.postData(
      url: ADDCART,
      token: token!,
      data: {
        'id': cartId,
      },
    ).then((value) {
      addCartModel = AddCartModel.fromJson(value.data);
      print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
      print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
      print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
      emit(AddCartSuccessState(addCartModel!));
    }).catchError((error) {
      print(error.toString());
      print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
      emit(AddCartErrorState());
    });
  }

//***********************************************

  LogoutModel? logoutModel;

  void logout() {
    DioHelper.postData(url: LOGOUT, token: token!, data: {}).then((value) {
      logoutModel = LogoutModel.fromJson(value.data);
      emit(LogoutSuccessState(logoutModel!));
    }).catchError((error) {
      print(error.toString());
      emit(LogoutErrorState());
    });
  }

//******************************************************

  void pay({
    required String cardNumber,
    required String amount,
    required String cvv,
    required String expiryYear,
    required String expiryMonth,
  }) {}
}
