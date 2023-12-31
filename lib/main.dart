import 'package:flutter/material.dart';
import 'package:motorpool/providers/address_provider.dart';
import 'package:motorpool/providers/cart_provider.dart';
import 'package:motorpool/providers/dashboard_provider.dart';
import 'package:motorpool/providers/incident_provider.dart';
import 'package:motorpool/providers/trip_provider.dart';
import 'package:motorpool/providers/vehical_provider.dart';
import 'package:motorpool/screens/home/home_screen.dart';
import 'package:motorpool/screens/home/support_screen.dart';
import 'package:motorpool/screens/home/trip_screen.dart';
import 'package:motorpool/screens/home/vehicals_screen.dart';
import 'package:motorpool/screens/incidents/new_incident_screen.dart';
import 'package:motorpool/screens/loading_screen.dart';
import 'package:provider/provider.dart';

import './helpers/common/constants.dart';
import './helpers/common/routes.dart';
import './providers/auth.dart';
import './screens/cart/desktop/cart_desktop_screen.dart';
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
        ChangeNotifierProxyProvider<Auth, IncidentProvider>(
          update: (ctx, auth, _) {
            return IncidentProvider(auth.token, auth.currentUser);
          },
        ),
        ChangeNotifierProxyProvider<Auth, AddressProvider>(
          update: (ctx, auth, _) {
            return AddressProvider(auth.token, auth.currentUser);
          },
        ),
        ChangeNotifierProxyProvider<Auth, DashboardProvider>(
          update: (ctx, auth, _) {
            return DashboardProvider(auth.token, auth.currentUser);
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
                    labelLarge: TextStyle(
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
                    displayLarge: TextStyle(
                      fontSize: 62,
                      fontWeight: FontWeight.w300,
                      color: Constants.primaryColor,
                    ),
                    displayMedium: TextStyle(
                      fontSize: 62,
                      fontWeight: FontWeight.bold,
                      color: Constants.textColor,
                    ),
                    displaySmall: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Constants.textColor,
                    ),
                    headlineMedium: TextStyle(
                      fontSize: 32,
                      color: Constants.textColor,
                    ),
                    bodyLarge: TextStyle(
                      fontSize: 18,
                      color: Constants.textColor,
                    ),
                  ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              scaffoldBackgroundColor: Constants.backgroundColor,
              appBarTheme: AppBarTheme.of(context).copyWith(
                backgroundColor: Constants.primaryColor,
              )),
          home: authData.isAuth
              ? HomeScreen()
              : FutureBuilder(
                  future: authData.tryAutoLogin(),
                  builder: (ctx, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? LoadingScreen()
                          : ((snapshot.data != null
                                  ? (snapshot.data as bool)
                                  : false)
                              ? HomeScreen()
                              : LoginScreen()),
                ),
          routes: {
            Routes.loginScreen: (ctx) => LoginScreen(),
            Routes.homeScreen: (ctx) => HomeScreen(),
            Routes.tripsScreen: (ctx) => TripScreen(),
            Routes.vehicalsScreen: (ctx) => VehicalsScreen(),
            Routes.newIncidentScreen: (ctx) => NewIncidentScreen(),
            Routes.cartDesktopScreen: (ctx) => CartDesktopScreen(),
            Routes.supportScreen: (ctx) => SupportScreen(),
          },
        ),
      ),
    );
  }
}
