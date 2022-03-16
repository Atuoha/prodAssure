import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/products.dart';

// ignore: use_key_in_widget_constructors
class DetailsPage extends StatefulWidget {
  static String routeName = '/details';

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    var data =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    Product productDetails =
        Provider.of<Products>(context).fetchProductByID(data['id'] as String);

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.transparent,
          statusBarColor: Colors.transparent,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.deepOrange,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(120),
                  ),
                  child: Image.network(
                    productDetails.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productDetails.name,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.deepOrange,size:15),
                      Icon(Icons.star, color: Colors.deepOrange,size:15),
                      Icon(Icons.star, color: Colors.deepOrange,size:15),
                      Icon(Icons.star, color: Colors.deepOrange,size:15),
                      Icon(Icons.star, color: Colors.deepOrange,size:15),
                    ],
                  ),
                  Text('Manufacturer: ${productDetails.manufacturer}'),
                  Text(
                    'N${productDetails.price}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Text(
                        'Uploaded: ${DateFormat(' dd MMM yyy - hh:mma').format(
                      DateTime.parse(productDetails.date),
                    )}'),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Product Details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    productDetails.description,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: productDetails.status ? Colors.green : Colors.red,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          productDetails.status
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          productDetails.status ? 'ORIGNAL' : 'NOT ORIGINAL',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
