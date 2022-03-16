import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/bottom_navigation.dart';
import '../components/single_manage_product.dart';
import '../providers/products.dart';
import '../screens/add_and_edit_product.dart';

class ManageProducts extends StatefulWidget {
  static String routeName = '/manage_product';
  const ManageProducts({Key? key}) : super(key: key);

  @override
  State<ManageProducts> createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {
  var _isInit = true;
  var _isLoading = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () => Navigator.of(context).pushNamed(AddProduct.routeName),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.deepOrange,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const BottomNavigationComponent(),
              ),
            ),
            icon: const Icon(
              Icons.home,
              color: Colors.deepOrange,
            ),
          )
        ],
        automaticallyImplyLeading: false,
        title: const Text(
          'Manage Products',
          style: TextStyle(
            color: Colors.deepOrange,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.deepOrange,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Consumer<Products>(
                builder: (_, product, prod_2) => product.getCount < 1
                    ? const Center(
                        child: Text(
                          '😐 Opps! There are no products to preview!',
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () =>
                            Provider.of<Products>(context).fetchProducts(),
                        child: ListView.builder(
                          itemCount: product.getCount,
                          itemBuilder: (context, index) => SingleManageProduct(
                            name: product.availableProducts[index].name,
                            price: product.availableProducts[index].price,
                            image: product.availableProducts[index].image,
                            id: product.availableProducts[index].id,
                            manufacturer:
                                product.availableProducts[index].manufacturer,
                          ),
                        ),
                      ),
              ),
            ),
    );
  }
}
