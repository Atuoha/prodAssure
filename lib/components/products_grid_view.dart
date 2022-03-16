import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/detail_product.dart';

import 'single_product.dart';

// ignore: must_be_immutable
class ProductGridView extends StatefulWidget {
  List<Product> products;
  // ignore: use_key_in_widget_constructors
  ProductGridView({required this.products});
  @override
  State<ProductGridView> createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<ProductGridView> {
  @override
  Widget build(BuildContext context) {
    return widget.products.isEmpty
        ? const Center(child: Text('😐 Opps! There are no products to preview!'))
        : GridView.count(
            padding: EdgeInsets.zero,
            crossAxisCount: 2,
            children: widget.products.map((product) {
              return GestureDetector(
                onTap: () => Navigator.of(context)
                    .pushNamed(DetailsPage.routeName, arguments: {
                  'id': product.id,
                }),
                child: SingleProduct(
                  name: product.name,
                  details: product.description,
                  price: product.price,
                  image: product.image,
                  producer: product.manufacturer,
                ),
              );
            }).toList());
  }
}
