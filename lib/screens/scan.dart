import 'package:flutter/material.dart';
import 'package:prod_assure/screens/detail_product.dart';
import 'package:provider/provider.dart';
import '../components/bottom_design.dart';
import '../components/top_design.dart';
import '../providers/products.dart';

class Scan extends StatefulWidget {
  const Scan({Key? key}) : super(key: key);

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  String _scanCode = '';
  var _isLoading = false;
  String productId = '';
  String errorCode = '';
  var error = false;

  @override
  void dispose() {
    _scanCode;
    _isLoading;
    productId;
    errorCode;
    error;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void scanProduct(String code) async {
    // ignore: avoid_print
    print(_scanCode);

    try {
      setState(
        () {
          _isLoading = true;
        },
      );
      await Provider.of<Products>(context, listen: false)
          .scanProduct(code)
          .then(
            (_) => {
              productId =
                  Provider.of<Products>(context, listen: false).scannedProduct,
              // ignore: avoid_print
              print(productId),
              // ignore: unnecessary_null_comparison
              if (productId != '')
                {
                  Navigator.of(context).pushNamed(DetailsPage.routeName,
                      arguments: {'id': productId}).then(
                    (value) => {
                      setState(
                        () {
                          Provider.of<Products>(context, listen: false)
                              .resetIDs();
                        },
                      )
                    },
                  )
                }
              else
                {
                  setState(
                    () {
                      error = true;
                      errorCode =
                          '😣 Opps! Code doesn\'t match any product here!';
                    },
                  )
                },
              setState(
                () {
                  _isLoading = false;
                },
              )
            },
          );
    } catch (e) {
      // ignore: avoid_print
      print('AN error occured while scanning product $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TopDesign(
          title: 'Scan Product',
          subtitle: '...scanning products to know authenticity',
        ),
        BottomDesign(
          widget: Padding(
            padding: const EdgeInsets.only(right: 15, top: 8, left: 5),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(
                    'assets/imgs/c.jpeg',
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: TextField(
                        onSubmitted: (value) => {
                          setState(
                            () {
                              if (value != '') {
                                scanProduct(value);
                              }
                            },
                          )
                        },
                        onChanged: (value) => {
                          setState(
                            () {
                              _scanCode = value;
                            },
                          )
                        },
                        textInputAction: TextInputAction.search,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 18),
                          border: InputBorder.none,
                          hintText: 'Enter Code Number',
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      trailing: IconButton(
                        padding: const EdgeInsets.only(bottom: 18),
                        onPressed: () {
                          if (_scanCode != '') {
                            scanProduct(_scanCode);
                          }
                        },
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                _isLoading
                    ? const Padding(
                        padding: EdgeInsets.only(top: 50.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.deepOrange,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  errorCode,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 201, 200, 200),
                                  ),
                                ),
                                if (error)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      'assets/imgs/ss.png',
                                      width: 500,
                                      height: 200,
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
