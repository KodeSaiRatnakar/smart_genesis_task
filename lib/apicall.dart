import 'dart:convert';

import 'package:http/http.dart';

import 'modelclass.dart';


class ApiCall{
  static Future<List<Product>> getProductsFromApi() async {
    Response response = await get(
        Uri.parse(
          "https://fakestoreapi.com/products",
        ),);

    if (response.statusCode == 200) {


      List<Map> data =[];

      List fetched_data = jsonDecode(response.body);

      return Product.convertListToProductList(fetched_data);

    }
    else {

      throw Exception(response.reasonPhrase);
    }
  }
}
