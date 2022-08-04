import 'package:cashair/models/add_cart_model.dart';
import 'package:cashair/models/get_carts_model.dart';
import 'package:cashair/models/home_model.dart';
import 'package:cashair/models/log_out_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopGetUserState extends ShopStates {}

class GetCartIdState extends ShopStates {}

//****************************************************************************
class HomeLoadingState extends ShopStates {}

class HomeSuccessState extends ShopStates {
  final HomeModel model;

  HomeSuccessState(this.model);
}

class HomeErrorState extends ShopStates {}

//****************************************************************************
class AddCartLoadingState extends ShopStates {}

class AddCartSuccessState extends ShopStates {
  final AddCartModel  model;

  AddCartSuccessState(this.model);

}

class AddCartErrorState extends ShopStates {}
//****************************************************************************
//****************************************************************************
class GetCartLoadingState extends ShopStates {}

class GetCartSuccessState extends ShopStates {
  final GetCartsModel model;

  GetCartSuccessState(this.model);
}

class GetCartErrorState extends ShopStates {}
//****************************************************************************
class LogoutSuccessState extends ShopStates {
  final LogoutModel model;

  LogoutSuccessState(this.model);
}
class LogoutErrorState extends ShopStates {}

