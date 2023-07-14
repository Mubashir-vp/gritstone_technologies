import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gritstone_technologies/core/model/local_db/location_model/location_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../core/data/services/hive_manager.dart';

class LocationListingScreen extends StatefulWidget {
  const LocationListingScreen({super.key});

  @override
  State<LocationListingScreen> createState() => _LocationListingScreenState();
}

class _LocationListingScreenState extends State<LocationListingScreen> {
  late ScrollController scrollController;
  late Box<LocationModel> locationBox;
  int displayItemCount = 20;
  int length = 0;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.atEdge &&
          scrollController.position.pixels != 0) {
        setState(() {
          displayItemCount += 20;
        });
      }
    });
  }

  Future<Box<LocationModel>>? _initializeBox() async {
    locationBox = await HiveManager.getLocationBox();
    return locationBox;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.move_down_outlined),
        onPressed: () {
          final itemCount = locationBox.keys.cast<int>().toList().length;
          final isAtBottom = scrollController.position.pixels ==
              scrollController.position.maxScrollExtent;
          final double targetScroll =
              isAtBottom ? 0 : itemCount.toDouble() * 100.0;

          scrollController.animateTo(
            targetScroll,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xfffc7a392),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1500));
          setState(() {});
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: FutureBuilder(
                future: _initializeBox(),
                builder: (
                  context,
                  AsyncSnapshot<Box<LocationModel>> snapshot,
                ) {
                  if (snapshot.hasData) {
                    return ValueListenableBuilder(
                        valueListenable: snapshot.data!.listenable(),
                        builder: (context, Box<LocationModel> location, cntxt) {
                          List<int> keys =
                              snapshot.data!.keys.cast<int>().toList();
                          log('*>>>>>>>>>>>>>>>>>>>>>>>>>>>>length${keys.length}');
                          return ListView.separated(
                            controller: scrollController,
                            itemBuilder: (context, index) {
                              if (index < displayItemCount) {
                                final int key = keys[index];
                                final LocationModel? data =
                                    snapshot.data!.get(key);
                                return ListTile(
                                  tileColor: const Color(0xfffc7a392),
                                  leading: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Latitude : ${data!.lat}',
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Latitude : ${data.lon}',
                                      ),
                                    ],
                                  ),
                                  title: Text('Battery : ${data.batteryLevel}'),
                                  trailing: Column(
                                    children: [
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${data.currentTime.day}.${data.currentTime.month}.${data.currentTime.year}',
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${data.currentTime.hour}:${data.currentTime.minute}:${data.currentTime.second}',
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                return const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                            itemCount: displayItemCount <= keys.length
                                ? displayItemCount
                                : keys.length,
                          );
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })),
      ),
    );
  }
}
