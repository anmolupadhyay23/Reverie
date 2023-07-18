import 'package:flutter/material.dart';
import 'package:riverie/features/account/screens/yourOrders.dart';
import 'package:riverie/features/address/screens/addressScreen.dart';
import 'package:riverie/features/admin/screens/addProduct.dart';
import 'package:riverie/features/auth/screens/authScreen.dart';
import 'package:riverie/features/auth/screens/createAccount.dart';
import 'package:riverie/features/home/screens/homeScreen.dart';
import 'package:riverie/features/productDetails/screens/productDetailScreen.dart';
import 'package:riverie/features/search/screens/searchScreen.dart';
import 'package:riverie/features/wishlist/screens/wishlistScreen.dart';
import 'package:riverie/model/order.dart';
import 'package:riverie/model/product.dart';
import 'package:riverie/widgets/bottomBar.dart';

import 'features/customization/screens/customizationScreen.dart';
import 'features/home/screens/categoryScreen.dart';
import 'features/orderDetails/screens/orderDetailsScreen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch(routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const AuthScreen()
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const HomeScreen()
      );
    case createAccount.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const createAccount()
      );
    case bottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const bottomBar()
      );
    case AddProduct.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const AddProduct()
      );
    case CategoryScreen.routeName:
      var category=routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryScreen(
              category: category,
          )
      );
    case SearchScreen.routeName:
      var searchQuery=routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SearchScreen(
            searchQuery: searchQuery,
          )
      );
    case ProductDetailScreen.routeName:
      var product=routeSettings.arguments as Product;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductDetailScreen(
              product: product,
          )
      );
    case AddressScreen.routeName:
      var totalAmount=routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => AddressScreen(
            totalAmount: totalAmount,
          )
      );
    case OrderDetailsScreen.routeName:
      var order=routeSettings.arguments as Order;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) =>  OrderDetailsScreen(
              order: order,
          )
      );
    case WishList.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const WishList()
      );
    case YourOrders.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const YourOrders()
      );
    case CustomizationScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const CustomizationScreen()
      );
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Screen not available!'),
            ),
          )
      );
  }
}