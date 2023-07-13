import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:gritstone_technologies/core/model/product_model.dart';

class HttpServices {
  Future<(ProductModel, ProductModel)?> fetchProducts() async {
    String productUrl = "https://dummyjson.com/products";
    String categoryUrl = 'https://dummyjson.com/products/category/smartphones';
    var productPathurl = Uri.parse(productUrl);
    var categoryPathurl = Uri.parse(categoryUrl);

    try {
      var productResponse = await http.get(
        productPathurl,
      );
      var categoryResponse = await http.get(
        categoryPathurl,
      );
      if (productResponse.statusCode == 200 &&
          categoryResponse.statusCode == 200) {
        String productString = productResponse.body;
        String categoryString = categoryResponse.body;
        ProductModel productData = productModelFromJson(productString);
        log('Length${productData.products!.length}');
        ProductModel categoryData = productModelFromJson(categoryString);
        return (productData, categoryData);
      } else {
        return null;
      }
    } on SocketException {
      return null;
    } catch (e) {
      return null;
    }
  }
}
