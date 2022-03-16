import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../screens/add_and_edit_product.dart';
import '../screens/detail_product.dart';

enum Operation { yes, no }

// ignore: must_be_immutable
class SingleManageProduct extends StatefulWidget {
  final String name;
  final double price;
  final String image;
  final String id;
  final String manufacturer;
  // ignore: use_key_in_widget_constructors
  SingleManageProduct({
    required this.name,
    required this.price,
    required this.image,
    required this.id,
    required this.manufacturer,
  });

  @override
  State<SingleManageProduct> createState() => _SingleManageProductState();
}

class _SingleManageProductState extends State<SingleManageProduct> {
  TextStyle style = const TextStyle(fontSize: 13);

  @override
  Widget build(BuildContext context) {
    Widget customActionButton(Operation operation) {
      return TextButton(
        onPressed: () {
          switch (operation) {
            case Operation.yes:
              Navigator.of(context).pop(true);
              break;
            case Operation.no:
              Navigator.of(context).pop(false);
              break;
            default:
          }
        },
        child: Text(
          operation.toString().replaceAll('Operation.', '').toUpperCase(),
        ),
      );
    }

    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        DetailsPage.routeName,
        arguments: {'id': widget.id},
      ),
      child: Dismissible(
        confirmDismiss: (direction) {
          return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                'Are you sure?',
              ),
              content: Text(
                'Do you want to delete ${widget.name} from your product list?',
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                customActionButton(Operation.yes),
                customActionButton(Operation.no),
              ],
            ),
          );
        },
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          Provider.of<Products>(context, listen: false).removeProduct(widget.id);
        },
        key: Key(widget.id),
        background: Container(
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.red,
          ),
          child: const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.delete,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
        child: Card(
          elevation: 3,
          // color: const Color.fromARGB(255, 216, 213, 213).withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              trailing: IconButton(
                onPressed: () => Navigator.of(context).pushNamed(
                  AddProduct.routeName,
                  arguments: {'id': widget.id},
                ).then((_) => {
                  setState((){

                  })
                }),
                icon: const Icon(
                  Icons.create,
                  color: Colors.deepOrange,
                  size: 25,
                ),
              ),
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  widget.image,
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    widget.manufacturer,
                    style: style,
                  ),
                  Text(
                    '\$${widget.price}',
                    style: style,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
