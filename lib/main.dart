import 'package:cashair/layout/cubit/shop_cubit.dart';
import 'package:cashair/layout/layout.dart';
import 'package:cashair/pages/login_screen/login_screen.dart';
import 'package:cashair/shared/constants.dart';
import 'package:cashair/shared/cubit/app_cubit.dart';
import 'package:cashair/shared/cubit/app_states.dart';
import 'package:cashair/shared/network/local/cash_helper.dart';
import 'package:cashair/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CashHelper.init();
  var cc = CashHelper.getString(key: 'token');
  cc == null ? token = null : token = cc;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xffF0F0F0),
  ));
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()),
        BlocProvider(create: (BuildContext context) => ShopCubit()..getProducts()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.orange,
              scaffoldBackgroundColor: Color(0xffF0F0F0),
              primaryColor: Color(0xffEB7F3B),
              accentColor: Color(0xff082F2E),
              appBarTheme: AppBarTheme(
                backgroundColor: Color(0xffF0F0F0),
                elevation: 0,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarBrightness: Brightness.light,
                  statusBarIconBrightness: Brightness.dark,
                ),
              ),
            ),
            home: token == null ? LoginScreen() : Home(),
          );
        },
      ),
    );
  }
}
