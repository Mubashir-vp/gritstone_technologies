import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:gritstone_technologies/core/model/product_model.dart';

import '../../bloc/home_bloc/home_bloc.dart';
import '../../model/local_db/hive_model/hive_model.dart';
import '../../model/local_db/local_product_model.dart/local_product_model.dart';
import 'database_services.dart';

class HttpServices {
  Future<
      HomeState
      // (ProductModel, ProductModel)?
      > fetchProducts() async {
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
        ProductModel categoryData = productModelFromJson(categoryString);
        List<LocalProduct> products = productData.products!.map(
          (e) {
            return LocalProduct(
              id: e.id,
              title: e.title,
              description: e.description,
              price: e.price,
              discountPercentage: e.discountPercentage,
              rating: e.rating,
              stock: e.stock,
              brand: e.brand,
              category: e.category,
              thumbnail: e.thumbnail,
              images: e.images,
            );
          },
        ).toList();
        List<LocalProduct> category = categoryData.products!.map(
          (e) {
            return LocalProduct(
              id: e.id,
              title: e.title,
              description: e.description,
              price: e.price,
              discountPercentage: e.discountPercentage,
              rating: e.rating,
              stock: e.stock,
              brand: e.brand,
              category: e.category,
              thumbnail: e.thumbnail,
              images: e.images,
            );
          },
        ).toList();

        await DataBaseServices().addData(
          product: HiveModel(products: products, category: category),
        );
        HiveModel? hiveModel = DataBaseServices().getData();
        int productIndex = 0;
        int categoryIndex = 0;
        List<LocalProduct> combinedList = [];
        for (int i = 1;
            i <= (hiveModel!.products.length + hiveModel.category.length);
            i++) {
          if (i % 6 == 0 && hiveModel.category.length >= categoryIndex) {
            combinedList.add(hiveModel.category[categoryIndex]);
            categoryIndex++;
          } else if (hiveModel.products.length - 1 >= productIndex) {
            combinedList.add(hiveModel.products[productIndex]);
            productIndex++;
          }
        }
        return DataLoaded(products: combinedList);
      } else {
        return const HomeFailed(
            errorMessage: 'Something went wrong , Please try again');
      }
    } on SocketException {
      return const HomeFailed(
          errorMessage: 'Network Error occured\n Please check your internet');
    } catch (e) {
      return HomeFailed(errorMessage: '$e');
    }
  }
}
