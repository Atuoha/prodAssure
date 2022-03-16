// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import '../screens/add_and_edit_product.dart';
import '../screens/detail_product.dart';
import '../screens/products.dart';
import 'package:provider/provider.dart';

import 'components/bottom_navigation.dart';
import 'providers/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (context)=>Products(),
      child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Montserrat',
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: Colors.deepOrange,
              primary: Colors.deepOrange,
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: const BottomNavigationComponent(),
          routes: {
            DetailsPage.routeName: (context) => DetailsPage(),
            AddProduct.routeName: (context) => const AddProduct(),
            ManageProducts.routeName: (context) => const ManageProducts(),
          },
      ),
    );
  }
}
