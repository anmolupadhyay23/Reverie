import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:riverie/constants/utils.dart';
import 'package:riverie/features/admin/services/adminServices.dart';
import 'package:riverie/features/admin/widgets/productTextField.dart';
import 'package:riverie/widgets/customButton.dart';

class AddProduct extends StatefulWidget {
  static const String routeName='/add-product';
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  final TextEditingController _productNameController=TextEditingController();
  final TextEditingController _descriptionController=TextEditingController();
  final TextEditingController _priceController=TextEditingController();
  final TextEditingController _quantityController=TextEditingController();
  final AdminServices adminServices=AdminServices();

  String category='T-shirts';
  List<File> images=[];
  List<File> designImage=[];
  final _addProductFormKey=GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _productNameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
  }

  List<String> productCategories = [
    'T-shirts',
    'Shirts',
    'Jeans',
    'Tops',
    'Trouser',
    'Sweater',
    'Jacket',
    'Coat'
  ];

  void sellProduct() {
    if(_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.SellProduct(
          context: context,
          name: _productNameController.text,
          description: _descriptionController.text,
          price: double.parse(_priceController.text),
          quantity: double.parse(_quantityController.text),
          category: category,
          images: designImage
      );
    }
  }

  void selectImages() async {
    var res=await pickImages();
    setState(() {
      images=res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              // gradient: GlobalVariables.appBarGradient, // Color can be changed from globalVariables
                color: Colors.white
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 60),
            child: const Text(
                'Add Product',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 20,),
                images.isNotEmpty ? CarouselSlider(
                  items: images.map((i) {
                    return Builder(
                        builder: (BuildContext context) => Image.file(
                          i,
                          fit: BoxFit.cover,
                          height: 200,
                        )
                    );
                  }).toList(),
                  options: CarouselOptions(
                      viewportFraction: 1,
                      height: 200
                  ),
                ) : GestureDetector(
                  onTap: selectImages,
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      dashPattern: const [10,4],
                      strokeCap: StrokeCap.round,
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.folder_open,
                              size: 40,
                            ),
                            const SizedBox(height: 15,),
                            Text(
                                'Select Product Images',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey.shade400
                              ),
                            )
                          ],
                        ),
                      )
                  ),
                ),
                const SizedBox(height: 30,),
                productTextField(
                    controller: _productNameController,
                    hintText: 'Product Name',
                ),
                const SizedBox(height: 10,),
                productTextField(
                    controller: _descriptionController,
                    hintText: 'Description',
                  maxLines: 7,
                ),
                const SizedBox(height: 10,),
                productTextField(
                  controller: _priceController,
                  hintText: 'Price',
                ),
                const SizedBox(height: 10,),
                productTextField(
                  controller: _quantityController,
                  hintText: 'Quantity',
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                    ),
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                          child: Text(
                            item
                          )
                      );
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        category=newVal!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: customButton(
                      text: 'Sell',
                      onTap: sellProduct,
                      fgColor: Colors.white,
                      bgColor: Colors.black
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
