import 'package:flutter/material.dart';

// String uri='http://192.168.29.45:3000';

String uri='http://192.168.247.153:3000';

class GlobalVariables {

  static const appBarGradient=LinearGradient(
    colors: [
      Color.fromARGB(255,29,201,192),
      Color.fromARGB(255,125,221,216),
    ],
    stops: [0.5, 1.0],
  );

  static const backgroundColor=Colors.white;
  static const secondaryColor=Color.fromRGBO(255, 153, 0, 1);

  // STATIC IMAGES
  static const List<String> carouselImages = [
    'https://i.pinimg.com/originals/fb/f8/6e/fbf86e47e28fe2eff60650904b726ba1.png',
    'https://dynamic.zacdn.com/aFXzg5f9mTexYZBA3rxhffv4Bw8=/fit-in/346x500/filters:quality(95):fill(ffffff)/https://static-hk.zacdn.com/p/topshop-0603-7583216-6.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1WU20mYZcaJCyEqCiVmaqFtYtMRh--O5nPA&usqp=CAU',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'T-shirts',
      'image': 'assets/default.jpg',
    },
    {
      'title': 'Shirts',
      'image': 'assets/default.jpg',
    },
    {
      'title': 'Jeans',
      'image': 'assets/default.jpg',
    },
    {
      'title': 'Tops',
      'image': 'assets/default.jpg',
    },
    {
      'title': 'Trouser',
      'image': 'assets/default.jpg',
    },
    {
      'title': 'Sweater',
      'image': 'assets/default.jpg',
    },
    {
      'title': 'Jacket',
      'image': 'assets/default.jpg',
    },
    {
      'title': 'Coat',
      'image': 'assets/default.jpg',
    },
  ];

}