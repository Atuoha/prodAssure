import 'package:flutter/material.dart';
import '../screens/add_and_edit_product.dart';
import '../screens/products.dart';

import '../constants/colors.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget menuBuild(String title, IconData icon, String routeName) {
      return ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: kBackground,
          ),
        ),
        leading: Icon(icon, color: kBackground),
        onTap: () => Navigator.of(context).pushNamed(routeName),
      );
    }

    return Drawer(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/imgs/b5.jpg'),
                ),
              ),
              child: Container(
                color: Colors.grey.withOpacity(0.6),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 21,
                        backgroundImage: AssetImage('assets/imgs/default.png'),
                      ),
                      Text(
                        'Anthony A',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        'Product Manager',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: ListView(
                    children: [
                      menuBuild(
                        'Add Product',
                        Icons.add,
                        AddProduct.routeName,
                      ),
                      menuBuild(
                        'Manage Products',
                        Icons.list,
                        ManageProducts.routeName,
                      ),
                      menuBuild(
                        'History',
                        Icons.calendar_today,
                        '',
                      ),
                      menuBuild(
                        'Statistics',
                        Icons.bar_chart,
                        '',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ListView(
                    children: [
                      const Divider(),
                      menuBuild('Share App', Icons.share, ''),
                      menuBuild('Rate App', Icons.star_outline, ''),
                      menuBuild('Sign out', Icons.logout, ''),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
