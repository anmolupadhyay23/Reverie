import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../constants/errorHandling.dart';
import '../../../constants/globalVariables.dart';
import '../../../constants/utils.dart';
import '../../../model/product.dart';
import '../../../provider/user_provider.dart';

class SearchServices{
  Future<List<Product>> fetchSearchProducts({
    required BuildContext context,
    required String searchQuery,
  }) async{
    final userProvider=Provider.of<UserProvider>(context,listen: false);
    List<Product> productList=[];
    try{
      http.Response res=await http.get(
        Uri.parse('$uri/api/products/search/$searchQuery'),
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
}