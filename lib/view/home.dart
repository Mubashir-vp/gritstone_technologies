import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gritstone_technologies/core/model/local_db/local_product_model.dart/local_product_model.dart';
import 'package:gritstone_technologies/widgets/cardwidget.dart';
import '../core/bloc/home_bloc/home_bloc.dart';
import 'location_listing_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const LocationListingScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.location_city,
            ),
          ),
        ],
        backgroundColor: const Color(0xfffc7a392),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HomeFailed) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            } else if (state is DataLoaded) {
              return Column(
                children: buildTile(
                  products: state.products,
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  buildTile({
    required List<LocalProduct> products,
  }) {
    return products
        .map(
          (e) => CardWidget(product: e),
        )
        .toList();
  }
}
