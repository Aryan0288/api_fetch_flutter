import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

class ApiProviders extends ChangeNotifier {
  var apiDataResponse = [];
  var addCarts = [];

  ApiProviders() {
    fetchData();
  }

  Future<void> fetchData() async {
    // var url = Uri.https("https://fakestoreapi.com/products?limit=1");
    // var response = await http.get(url);
    var url = Uri.parse("https://fakestoreapi.com/products?limit=100");
    var response = await http.get(url);

    var jsonDec = jsonDecode(response.body);
    apiDataResponse = jsonDec;
    notifyListeners();
  }

  void addToCart(dynamic item, BuildContext context) {
    if (addCarts.contains(item)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item already added to the cart'),
        ),
      );
      return;
    }
    addCarts.add(item);
    notifyListeners();
  }

  void removeFromCart(dynamic item) {
    addCarts.remove(item);
    notifyListeners();
  }
}
