import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gritstone_technologies/core/bloc/home_bloc/home_bloc.dart';
import 'package:gritstone_technologies/core/model/local_db/local_product_model.dart/local_product_model.dart';
import 'package:gritstone_technologies/view/home.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'core/model/local_db/hive_model/hive_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory path = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(path.path);
  Hive.registerAdapter(HiveModelAdapter());
  Hive.registerAdapter(LocalProductAdapter());
  await Hive.openBox<HiveModel>('hive_box');
  runApp(
    BlocProvider(
      create: (context) {
        return HomeBloc()
          ..add(
            const LoadData(),
          );
      },
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xfffc7a392)),
      ),
      home: const HomeScreen(),
    );
  }
}
