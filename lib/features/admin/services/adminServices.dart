import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riverie/constants/errorHandling.dart';
import 'package:riverie/constants/globalVariables.dart';
import 'package:riverie/constants/utils.dart';
import 'package:riverie/model/order.dart';
import 'package:riverie/model/product.dart';
import 'package:http/http.dart' as http;

import '../../../provider/user_provider.dart';

class AdminServices {
  void SellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
}) async {
    final userProvider=Provider.of<UserProvider>(context,listen: false);
    try{
      final cloudinary=CloudinaryPublic('dpr4nhgk5', 'kl2cbijo');
      List<String> imageUrls=[];
      for(int i=0;i<images.length;i++){
        CloudinaryResponse res=await cloudinary.uploadFile(CloudinaryFile.fromFile(images[i].path,folder: name));
        imageUrls.add(res.secureUrl);
      }
      Product product=Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imageUrls,
          category: category,
          price: price
      );
      
      http.Response res=await http.post(
          Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
        body: product.toJson()
      );
      
      httpErrorHandle(response: res, context: context, onSuccess: () {
        showSnackBar(context, 'Product added successfully!');
        Navigator.pop(context);
      });

    }catch(e) {
      showSnackBar(context, e.toString());
    }
  }

  // FETCH PRODUCTS
  Future<List<Product>> fetchAllProducts(BuildContext context) async{
    final userProvider=Provider.of<UserProvider>(context,listen: false);
    List<Product> productList=[];
    try{
      http.Response res=await http.get(
        Uri.parse('$uri/admin/get-products'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
      );
      httpErrorHandle(response: res, context: context, onSuccess: () {
        for(int i=0;i<jsonDecode(res.body).length;i++){
          productList.add(
            Product.fromJson(jsonEncode(jsonDecode(res.body)[i],
            ),
            ),
          );
        }
      });
    } catch(e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  // DELETE PRODUCT
  void deleteProduct(
  {required BuildContext context,
  required Product product,
  required VoidCallback onSuccess,}) async {
    final userProvider=Provider.of<UserProvider>(context,listen: false);
    try{
      http.Response res=await http.post(
          Uri.parse('$uri/admin/delete-product'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode({
            'id': product.id
          }),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
          }
      );

    }catch(e) {
      showSnackBar(context, e.toString());
    }
  }

  // FETCH ALL ORDERS
  Future<List<Order>> fetchAllOrders(BuildContext context) async{
    final userProvider=Provider.of<UserProvider>(context,listen: false);
    List<Order> orderList=[];
    try{
      http.Response res=await http.get(
        Uri.parse('$uri/admin/get-orders'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
      );
      httpErrorHandle(response: res, context: context, onSuccess: () {
        for(int i=0;i<jsonDecode(res.body).length;i++){
          orderList.add(
            Order.fromJson(jsonEncode(jsonDecode(res.body)[i],
            ),
            ),
          );
        }
      });
    } catch(e) {
      showSnackBar(context, e.toString());
    }
    return orderList;
  }

  // CHANGE ORDER STATUS
  void changeOrderStatus(
      {required BuildContext context,
        required int status,
        required Order order,
        required VoidCallback onSuccess,}) async {
    final userProvider=Provider.of<UserProvider>(context,listen: false);
    try{
      http.Response res=await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
        body: jsonEncode({
          'id': order.id,
          'status': status, // VALUE OF STATUS IS NOT UPDATING (STATUS: 0)
        }),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: onSuccess
      );

    }catch(e) {
      showSnackBar(context, e.toString());
    }
  }
}