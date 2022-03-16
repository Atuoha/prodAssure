import 'dart:convert';
import 'dart:math';

import 'package:flutter/widgets.dart';

import '../models/product.dart';
import 'package:http/http.dart' as http;

class Products extends ChangeNotifier {
  String _scannedProductId = '';
  String _searchedProductId = '';

  String get scannedProduct {
    return _scannedProductId;
  }

  void resetIDs() {
    _scannedProductId = '';
    _searchedProductId = '';
    notifyListeners();
  }

  String get searchedProduct {
    return _searchedProductId;
  }

  List<Product> get availableProducts {
    return [..._availableProducts];
  }

  int get getCount {
    return _availableProducts.length;
  }

  Product fetchProductByID(String id) {
    return _availableProducts.firstWhere((prod) => prod.id == id);
  }

  bool isProductStatusTrue(String id) {
    var product = _availableProducts.firstWhere((prod) => prod.id == id);
    if (product.status) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> toggleStatus(String id, bool status) async {
    var uri = Uri.parse(
        'https://prodassure-default-rtdb.firebaseio.com/products/$id.json');
    var product = _availableProducts.firstWhere((prod) => prod.id == id);
    var productIndex = _availableProducts.indexWhere((prod) => prod.id == id);
    var updatedProduct = Product(
      id: product.id,
      name: product.name,
      price: product.price,
      image: product.image,
      code: product.code,
      description: product.description,
      status: status,
      userId: product.userId,
      manufacturer: product.manufacturer,
      date: product.date,
    );

    try {
      await http.patch(
        uri,
        body: json.encode(
          {
            'name': product.name,
            'price': product.price,
            'image': product.image,
            'code': product.code,
            'description': product.description,
            'status': status,
            'manufacturer': product.manufacturer,
            'userId': product.userId,
            'date': product.date,
          },
        ),
      );
      _availableProducts[productIndex] = updatedProduct;
      notifyListeners();
    } catch (e) {
      // ignore: avoid_print
      print('an error occured $e');
    }
  }

  Future<void> fetchProducts() async {
    var uri = Uri.parse(
        'https://prodassure-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.get(uri);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedData = [];
      // ignore: unnecessary_null_comparison
      if (extractedData != null) {
        extractedData.forEach(
          (prodId, details) => {
            loadedData.add(
              Product(
                id: prodId,
                name: details['name'],
                description: details['description'],
                manufacturer: details['manufacturer'],
                date: details['date'],
                price: details['price'],
                code: details['code'],
                status: details['status'],
                image: details['image'],
                userId: details['userID'],
              ),
            )
          },
        );
      }
      _availableProducts = loadedData;
      notifyListeners();
    } catch (e) {
      // ignore: avoid_print
      print('an error occured $e');
    }
  }

  Future<void> scanProduct(String code) async {
    var uri = Uri.parse(
        'https://prodassure-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.get(uri);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((prodId, details) {
        if (details['code'] == code) {
          _scannedProductId = prodId;
        }
      });
      notifyListeners();
    } catch (e) {
      // ignore: avoid_print
      print('An error occured $e');
    }
  }

  Future<void> searchProduct(String keyword) async {
    var uri = Uri.parse(
        'https://prodassure-default-rtdb.firebaseio.com/products.json');

    try {
      final response = await http.get(uri);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((prodId, details) {
        if (details['name'] == keyword ||
            details['manufacturer'] == keyword ||
            details['price'] == keyword) {
          _searchedProductId = prodId;
        }
      });
      notifyListeners();
    } catch (e) {
      // ignore: avoid_print
      print('An error occured $e');
    }
  }

  Future<void> addProduct(Product product) async {
    var uri = Uri.parse(
        'https://prodassure-default-rtdb.firebaseio.com/products.json');
    Random random = Random();
    var code = random.nextInt(90) + 1090;

    try {
      var response = await http.post(
        uri,
        body: json.encode(
          {
            'name': product.name,
            'manufacturer': product.manufacturer,
            'price': product.price,
            'description': product.description,
            'status': true,
            'userID': '',
            'code': '00$code',
            'image': product.image,
            'date': DateTime.now().toString()
          },
        ),
      );

      var newProduct = Product(
        id: json.decode(response.body)['name'],
        name: product.name,
        price: product.price,
        description: product.description,
        image: product.image,
        manufacturer: product.manufacturer,
        status: true,
        code: code.toString(),
        userId: '',
        date: DateTime.now().toString(),
      );
      _availableProducts.add(newProduct);
      notifyListeners();
    } catch (e) {
      // ignore: avoid_print
      print('An error occured $e');
    }
  }

  Future<void> removeProduct(String id) async {
    var uri = Uri.parse(
        'https://prodassure-default-rtdb.firebaseio.com/products/$id.json');

    try {
      await http.delete(uri).then((response) => {
            if (response.statusCode >= 400)
              {
                // An error occured
              }
            else
              {_availableProducts.removeWhere((prod) => prod.id == id)}
          });
    } catch (e) {
      // ignore: avoid_print
      print('aN ERROR OCCURED $e');
    }
    notifyListeners();
  }

  Future<void> updateProduct(Product product, String id, bool status) async {
    var uri = Uri.parse(
        'https://prodassure-default-rtdb.firebaseio.com/products/$id.json');
    var prodIndex = _availableProducts.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      try {
        http.patch(
          uri,
          body: json.encode(
            {
              'name': product.name,
              'manufacturer': product.manufacturer,
              'price': product.price,
              'description': product.description,
              'status': status,
              'code': product.code,
              'userId': product.userId,
              'image': product.image
            },
          ),
        );
        _availableProducts[prodIndex] = product;
      } catch (e) {
        // ignore: avoid_print
        print('an error occured $e');
      }
      notifyListeners();
    }
  }

  late List<Product> _availableProducts = [];
}
