import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gritstone_technologies/core/model/local_db/local_product_model.dart/local_product_model.dart';
import 'package:gritstone_technologies/widgets/cardwidget.dart';

import '../core/bloc/home_bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xfffc7a392),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomeFailed) {
            return Center(
              child: Text(
                state.errorMessage,
              ),
            );
          } else if (state is DataLoaded) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return CardWidget(product: state.products[index]);
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  buildTile(
      {required List<LocalProduct> products,
      required List<LocalProduct> category}) {}
}
