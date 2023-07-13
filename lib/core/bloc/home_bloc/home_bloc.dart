import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gritstone_technologies/core/data/services/database_services.dart';
import 'package:gritstone_technologies/core/data/services/http_services.dart';
import 'package:gritstone_technologies/core/model/local_db/local_product_model.dart/local_product_model.dart';

import '../../model/local_db/hive_model/hive_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading()) {
    on<LoadData>((event, emit) async {
      emit(HomeLoading());
      var response = await HttpServices().fetchProducts();
      if (response != null) {
        List<LocalProduct> products = response.$1.products!.map(
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
        List<LocalProduct> category = response.$2.products!.map(
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
        HiveModel hiveModel = DataBaseServices().getData();
        int productIndex = 0;
        int categoryIndex = 0;
        List<LocalProduct> combinedList = [];
        for (int i = 1;
            i <= (hiveModel.products.length + hiveModel.category.length);
            i++) {
          if (i % 6 == 0 && hiveModel.category.length >= categoryIndex) {
            combinedList.add(hiveModel.category[categoryIndex]);
            categoryIndex++;
          } else if (hiveModel.products.length - 1 >= productIndex) {
            combinedList.add(hiveModel.products[productIndex]);
            productIndex++;
          }
        }

        emit(
          DataLoaded(
            products: combinedList,
          ),
        );
      }
    });
  }
}
