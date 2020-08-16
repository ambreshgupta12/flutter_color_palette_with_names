import 'package:flutter/material.dart';
import 'package:flutter_cart_item_add/notifiers/cart_provider.dart';
import 'package:flutter_cart_item_add/ui/cart_screen.dart';
import 'package:flutter_cart_item_add/ui/catelog_screen.dart';
import 'package:provider/provider.dart';

import 'model/catalog_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        Provider<CataLogModel>(create: (context) => CataLogModel()),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartProvider depends
        // on CatalogModel, so a ProxyProvider is needed.
        ChangeNotifierProxyProvider<CataLogModel, CartProvider>(
          create: (context) => CartProvider(),
          update: (context, catalog, cart) {
            cart.catalog = catalog;
            return cart;
          },
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
          textTheme: TextTheme(
            headline2:TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 24,
              color: Colors.red,
              fontFamily: 'Corben',
            ) ,
              headline1: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: Colors.black87,
            fontFamily: 'Corben',
          )),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/cart': (context) => CartScreen(),
          '/catalog': (context) => CatalogScreen(),
        },
        home: CatalogScreen(),
      ),
    );
  }
}
