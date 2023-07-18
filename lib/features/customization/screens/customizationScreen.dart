import 'dart:io';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../../../constants/utils.dart';
import '../../../widgets/customButton.dart';
import '../../admin/services/adminServices.dart';
import '../../admin/widgets/productTextField.dart';
import 'dart:ui' as ui;

class CustomizationScreen extends StatefulWidget {
  static const String routeName='/customize-product';
  const CustomizationScreen({Key? key}) : super(key: key);

  @override
  State<CustomizationScreen> createState() => _CustomizationScreenState();
}

class _CustomizationScreenState extends State<CustomizationScreen> {

  final TextEditingController _productNameController=TextEditingController();
  final TextEditingController _descriptionController=TextEditingController();
  final TextEditingController _priceController=TextEditingController();
  final TextEditingController _quantityController=TextEditingController();
  final AdminServices adminServices=AdminServices();

  final _screenShotController=ScreenshotController();

  String category='Mobiles';
  List<File> images=[];
  final _addProductFormKey=GlobalKey<FormState>();

  OverlayEntry? entry;
  Offset offset=Offset(20, 40);
  bool isDesign=false;
  bool isFinalReady=false;

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
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

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
          title: const Padding(
            padding: EdgeInsets.only(left: 40),
            child: Text(
              'Customize Product',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            images.isNotEmpty ? CarouselSlider(
              items: images.map((i) {
                return Screenshot(
                  controller: _screenShotController,
                  child: Builder(
                      builder: (BuildContext context) => Image.file(
                        i,
                        fit: BoxFit.cover,
                        height: 200,
                      )
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                  viewportFraction: 1,
                  height: MediaQuery.of(context).size.height*0.7
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
                    height: MediaQuery.of(context).size.height*0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          MdiIcons.tshirtCrewOutline,
                          size: 40,
                        ),
                        const SizedBox(height: 15,),
                        Text(
                          'Select your style',
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
            TextButton(
                onPressed: selectImages,
                child: Text('Add another image')
            )
          ],
        ),
      ),
    ),
    );
  }
}
