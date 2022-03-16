import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';

import '../providers/products.dart';
import 'products.dart';

enum Data {
  name,
  description,
  manufacturer,
  price,
  image,
}

class AddProduct extends StatefulWidget {
  static String routeName = '/add_product';
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var _isInit = true;
  final _nameNode = FocusNode();
  final _descriptionNode = FocusNode();
  final _manufacturerNode = FocusNode();
  final _priceNode = FocusNode();
  final _imageNode = FocusNode();

  final _form = GlobalKey<FormState>();
  var _adding = true;
  var _editingId = '';
  var _editProductStatus = true;

  var _editProduct = Product(
    id: '',
    name: '',
    description: '',
    manufacturer: '',
    date: DateTime.now().toString(),
    price: 0,
    code: '',
    status: true,
    image: '',
    userId: '',
  );

  final _imageController = TextEditingController();
  var _initValues = {
    'name': '',
    'description': '',
    'manufacturer': '',
    'price': '',
    'status': true,
    'code': '',
    'date': '',
    'userId': '',
    'image': '',
  };

  void _updateImageUrl() {
    if (!_imageNode.hasFocus) {
      if (!_imageController.text.startsWith('https')) {
        return;
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    _imageController.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // fetch products
    if (_isInit) {
      var id =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      // ignore: unnecessary_null_comparison
      if (id != null) {
        _adding = false;
        _editProduct =
            Provider.of<Products>(context, listen: false).fetchProductByID(
          id['id'] as String,
        );
        setState(
          () => {
            _editingId = id['id'] as String,
            _editProductStatus = _editProduct.status
          },
        );

        _initValues = {
          'name': _editProduct.name,
          'description': _editProduct.description,
          'manufacturer': _editProduct.manufacturer,
          'price': _editProduct.price.toString(),
          'code': _editProduct.code,
          'status': _editProductStatus,
          'date': _editProduct.date,
          'userId': _editProduct.userId,
          'image': '',
        };
        _imageController.text = _editProduct.image;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _nameNode.dispose();
    _imageNode.dispose();
    _priceNode.dispose();
    _manufacturerNode.dispose();
    _descriptionNode.dispose();
    _imageNode.removeListener(_updateImageUrl);

    super.dispose();
  }

  void _saveData() {
    final _isValid = _form.currentState!.validate();
    if (!_isValid) {
      return;
    }
    _form.currentState!.save();
    if (_adding) {
      // add product
      Provider.of<Products>(context, listen: false).addProduct(_editProduct);
    } else {
      // update product
      Provider.of<Products>(context, listen: false).updateProduct(
        _editProduct,
        _editingId,
        _editProductStatus,
      );
    }
    Navigator.pushNamed(
      context,
      ManageProducts.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget customTextFields(
        Data data,
        var initValue,
        IconData icon,
        String name,
        int minLines,
        int maxLines,
        TextInputType type,
        FocusNode node) {
      return TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Enter value for ${data.toString().replaceAll('Data.', '')}';
          }

          if (data == Data.price) {
            if (double.tryParse(value) == null) {
              return 'Enter a valid price';
            }

            if (double.parse(value) <= 0) {
              return 'Enter a price greater than zero';
            }
          }

          // Validating Description ONLY
          if (data == Data.description) {
            if (value.length < 10) {
              return 'Should be atleast 10 characters long';
            }
          }
          return null;
        },
        focusNode: node,
        initialValue: initValue,
        keyboardType: type,
        textInputAction: TextInputAction.next,
        minLines: minLines,
        maxLines: maxLines,
        autofocus: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 2,
              color: Colors.deepOrange,
            ),
          ),
          hintText: 'Text here',
          hintStyle: const TextStyle(fontSize: 15),
          label: Text(name),
          icon: Icon(
            icon,
          ),
        ),
        onSaved: (value) {
          switch (data) {
            case Data.name:
              _editProduct = Product(
                id: '',
                name: value.toString(),
                description: _editProduct.description,
                manufacturer: _editProduct.manufacturer,
                date: _editProduct.date,
                price: _editProduct.price,
                code: _editProduct.code,
                status: _editProduct.status,
                image: _editProduct.image,
                userId: _editProduct.userId,
              );
              break;
            case Data.price:
              _editProduct = Product(
                id: '',
                name: _editProduct.name,
                description: _editProduct.description,
                manufacturer: _editProduct.manufacturer,
                date: _editProduct.date,
                price: double.parse(value.toString()),
                code: _editProduct.code,
                status: _editProduct.status,
                image: _editProduct.image,
                userId: _editProduct.userId,
              );
              break;
            case Data.description:
              _editProduct = Product(
                id: '',
                name: _editProduct.name,
                description: value.toString(),
                manufacturer: _editProduct.manufacturer,
                date: _editProduct.date,
                price: _editProduct.price,
                code: _editProduct.code,
                status: _editProduct.status,
                image: _editProduct.image,
                userId: _editProduct.userId,
              );
              break;
            case Data.manufacturer:
              _editProduct = Product(
                id: '',
                name: _editProduct.name,
                description: _editProduct.description,
                manufacturer: value.toString(),
                date: _editProduct.date,
                price: _editProduct.price,
                code: _editProduct.code,
                status: _editProduct.status,
                image: _editProduct.image,
                userId: _editProduct.userId,
              );
              break;
            default:
          }
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: _saveData,
        child: const Icon(
          Icons.save,
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
        automaticallyImplyLeading: false,
        actions: [
          _adding
              ? Row(
                  children: const [
                    Text(
                      'Status:',
                      style: TextStyle(
                        color: Colors.deepOrange,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Active',
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                )
              : Row(
                  children: [
                    const Text(
                      'Status',
                      style: TextStyle(
                        color: Colors.deepOrange,
                      ),
                    ),
                    Checkbox(
                      activeColor: Colors.deepOrange,
                      splashRadius: 20,
                      checkColor: Colors.white,
                      value: _editProductStatus,
                      onChanged: (value) {
                        setState(
                          () {
                            _editProductStatus = value!;
                          },
                        );
                      },
                    ),
                  ],
                )
        ],
        title: const Text(
          'Add Product',
          style: TextStyle(
            color: Colors.deepOrange,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _form,
          autovalidateMode: AutovalidateMode.always,
          child: ListView(
            children: [
              customTextFields(
                Data.name,
                _initValues['name'],
                Icons.text_fields,
                'Product Name',
                1,
                1,
                TextInputType.text,
                _nameNode,
              ),
              const SizedBox(height: 15),
              customTextFields(
                  Data.manufacturer,
                  _initValues['manufacturer'],
                  Icons.library_books,
                  'Product Manufacturer',
                  1,
                  1,
                  TextInputType.text,
                  _manufacturerNode),
              const SizedBox(height: 15),
              customTextFields(
                  Data.price,
                  _initValues['price'].toString(),
                  Icons.attach_money,
                  'Product Price',
                  1,
                  1,
                  TextInputType.number,
                  _priceNode),
              const SizedBox(height: 15),
              customTextFields(
                  Data.description,
                  _initValues['description'],
                  Icons.text_fields,
                  'Product Description',
                  3,
                  3,
                  TextInputType.text,
                  _descriptionNode),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter value for Image';
                        }
                        return null;
                      },
                      controller: _imageController,
                      keyboardType: TextInputType.url,
                      focusNode: _imageNode,
                      textInputAction: TextInputAction.done,
                      minLines: 1,
                      maxLines: 1,
                      autofocus: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 2,
                            color: Colors.deepOrange,
                          ),
                        ),
                        hintText: 'Text here',
                        hintStyle: const TextStyle(fontSize: 15),
                        label: const Text('Image Url'),
                        icon: const Icon(
                          Icons.image,
                        ),
                      ),
                      onFieldSubmitted: (_) {
                        _saveData();
                      },
                      onSaved: (value) {
                        _editProduct = Product(
                          id: '',
                          name: _editProduct.name,
                          description: _editProduct.description,
                          manufacturer: _editProduct.manufacturer,
                          date: _editProduct.date,
                          price: _editProduct.price,
                          code: _editProduct.code,
                          status: _editProduct.status,
                          image: value.toString(),
                          userId: _editProduct.userId,
                        );
                      },
                    ),
                  ),
                  if (_imageController.text != '')
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        height: 90,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 2,
                            color: Colors.deepOrange,
                          ),
                          image: DecorationImage(
                            image: NetworkImage(_imageController.text),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
