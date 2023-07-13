// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gritstone_technologies/core/model/local_db/local_product_model.dart/local_product_model.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key, required this.product});
  final LocalProduct product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        8.0,
      ),
      child: Card(
        shadowColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: product.images!
                  .map((e) => SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.network(
                        e,
                        fit: BoxFit.fitWidth,
                      )))
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.title ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '\$ ${product.price.toString()}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xfffc7a392),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
