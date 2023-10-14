import 'package:flutter/material.dart';
import 'package:motorpool/providers/trip_provider.dart';
import 'package:motorpool/providers/vehical_provider.dart';
import 'package:motorpool/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:motorpool/providers/cart_provider.dart';
import './screens/cart/desktop/cart_desktop_screen.dart';

import './helpers/common/constants.dart';
import './helpers/common/routes.dart';

import './providers/auth.dart';

import './screens/splash_screen.dart';
import './screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) {
            return Auth();
          },
        ),
        ChangeNotifierProxyProvider<Auth, CartProvider>(
          update: (ctx, auth, _) {
            return CartProvider(auth.token, auth.currentUser);
          },
        ),
        ChangeNotifierProxyProvider<Auth, TripProvider>(
          update: (ctx, auth, _) {
            return TripProvider(auth.token, auth.currentUser);
          },
        ),
        ChangeNotifierProxyProvider<Auth, VehicalProvider>(
          update: (ctx, auth, _) {
            return VehicalProvider(auth.token, auth.currentUser);
          },
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, child) => MaterialApp(
          title: 'motorpool',
          theme: ThemeData(
            primaryColor: Constants.primaryColor,
            fontFamily: Constants.fontFamilyMontserrat,
            primaryTextTheme: Theme.of(context).primaryTextTheme.copyWith(
                  button: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
            inputDecorationTheme:
                Theme.of(context).inputDecorationTheme.copyWith(
                      hintStyle: TextStyle(
                        color: Constants.textFieldHintColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
            textTheme: Theme.of(context).textTheme.copyWith(
                  headline1: TextStyle(
                    fontSize: 62,
                    fontWeight: FontWeight.w300,
                    color: Constants.primaryColor,
                  ),
                  headline2: TextStyle(
                    fontSize: 62,
                    fontWeight: FontWeight.bold,
                    color: Constants.textColor,
                  ),
                  headline3: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Constants.textColor,
                  ),
                  headline4: TextStyle(
                    fontSize: 32,
                    color: Constants.textColor,
                  ),
                  bodyText1: TextStyle(
                    fontSize: 18,
                    color: Constants.textColor,
                  ),
                ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: authData.isAuth
              ? HomeScreen()
              : FutureBuilder(
                  future: authData.tryAutoLogin(),
                  builder: (ctx, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : ((snapshot.data != null
                                  ? (snapshot.data as bool)
                                  : false)
                              ? HomeScreen()
                              : LoginScreen()),
                ),
          routes: {
            Routes.loginScreen: (ctx) => LoginScreen(),
            Routes.homeScreen: (ctx) => HomeScreen(),
            Routes.cartDesktopScreen: (ctx) => CartDesktopScreen(),
          },
        ),
      ),
    );
  }
}
