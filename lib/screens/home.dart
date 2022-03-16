import 'package:flutter/material.dart';
import 'package:prod_assure/screens/detail_product.dart';
import 'package:provider/provider.dart';
import '../components/bottom_design.dart';
import '../components/top_design.dart';
import '../components/home_card.dart';
import '../components/products_grid_view.dart';
import '../constants/colors.dart';
import '../providers/products.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _isInit = true;
  var _isLoading = false;
  var _searchedKeyword = '';
  var _productId = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void searchProduct(String keyword) async {
    try {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Image.asset(
            'assets/imgs/loading.gif',
            width: 60,
            height: 60,
          ),
        ),
      );
      await Provider.of<Products>(context, listen: false)
          .searchProduct(_searchedKeyword)
          .then(
            (value) => {
              Navigator.pop(context),
              _productId =
                  Provider.of<Products>(context, listen: false).searchedProduct,
              if (_productId != '')
                {
                  Navigator.of(context).pushNamed(
                    DetailsPage.routeName,
                    arguments: {
                      'id': _productId,
                    },
                  ).then((value) => {
                        setState(() {
                          Provider.of<Products>(context, listen: false)
                              .resetIDs();
                        })
                      })
                }
              else
                {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Ok'),
                        ),
                      ],
                      content: Image.asset(
                        'assets/imgs/ss.png',
                        width: 150,
                        height: 130,
                      ),
                    ),
                  )
                }
            },
          );
    } catch (e) {
      // ignore: avoid_print
      print('An error occured $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TopDesign(
          title: 'Product Assurance',
          subtitle: '...assuring product\'s standards',
        ),
        BottomDesign(
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 90.0),
                        child: ListView(
                          // reverse: true,
                          scrollDirection: Axis.horizontal,
                          children: const [
                            HomeCard(
                              color: Color.fromARGB(162, 255, 86, 34),
                              title: 'Efficiency',
                              image: 'assets/imgs/c.jpeg',
                            ),
                            HomeCard(
                              color: Color.fromARGB(162, 78, 77, 77),
                              title: 'Speed',
                              image: 'assets/imgs/c.jpeg',
                            ),
                            HomeCard(
                              color: Color.fromARGB(255, 24, 80, 126),
                              title: 'Reliability',
                              image: 'assets/imgs/c.jpeg',
                            ),
                            HomeCard(
                              color: kBackground,
                              title: 'Active',
                              image: 'assets/imgs/c.jpeg',
                            ),
                            HomeCard(
                              color: Color.fromARGB(255, 121, 85, 72),
                              title: 'Updated',
                              image: 'assets/imgs/c.jpeg',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Hello there ✋',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'Welcome to Product Assurance! An app with features to authenticate products you buy',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Recently added Products ',
                                style: TextStyle(fontSize: 20),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: TextField(
                                        onSubmitted: (value) {
                                          if (value != '') {
                                            searchProduct(value);
                                          }
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            _searchedKeyword = value;
                                          });
                                        },
                                        textInputAction: TextInputAction.search,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding:
                                              EdgeInsets.only(bottom: 18),
                                          hintText: 'Type Keyword',
                                          hintStyle: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      trailing: GestureDetector(
                                        onTap: ()=>FocusScope.of(context).unfocus(),
                                        child: IconButton(
                                          padding:
                                              const EdgeInsets.only(bottom: 18),
                                          onPressed: () {
                                            if (_searchedKeyword != '') {
                                              searchProduct(_searchedKeyword);
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
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.deepOrange,
                          ),
                        )
                      : Consumer<Products>(
                          builder: (_, products, prod2) => ProductGridView(
                            products:
                                Provider.of<Products>(context, listen: false)
                                    .availableProducts,
                          ),
                        ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
