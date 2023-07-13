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
        24.0,
      ),
      child: Card(
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: product.images!
                  .map((e) => SizedBox(
                      height: 100, width: 200, child: Image.network(e)))
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.title ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                  color: Colors.blueGrey[50],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.price.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.blueGrey[50],
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.rating.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                  color: Colors.blueGrey[50],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
