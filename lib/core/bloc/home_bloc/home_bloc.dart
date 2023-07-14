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
      HiveModel? hiveModel = DataBaseServices().getData();
      if (hiveModel == null) {
        HomeState response = await HttpServices().fetchProducts();
        emit(response);
      } else {
        List<LocalProduct> combinedList = filterList(
          category: hiveModel.category,
          products: hiveModel.products,
        );
        emit(
          DataLoaded(
            products: combinedList,
          ),
        );
      }
    });
  }
  List<LocalProduct> filterList(
      {required List<LocalProduct> category,
      required List<LocalProduct> products}) {
    int productIndex = 0;
    int categoryIndex = 0;
    List<LocalProduct> combinedList = [];
    for (int i = 1; i <= (products.length + category.length); i++) {
      if (i % 6 == 0 && category.length >= categoryIndex) {
        combinedList.add(category[categoryIndex]);
        categoryIndex++;
      } else if (products.length - 1 >= productIndex) {
        combinedList.add(products[productIndex]);
        productIndex++;
      }
    }
    return combinedList;
  }
}
