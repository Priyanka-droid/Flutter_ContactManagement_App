// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_contact/models/custom_model.dart';
import 'package:flutter_contact/models/item_model.dart';
import 'package:hive_flutter/adapters.dart';

class HiveServices {
  // static HiveServices? _instance;

  // static HiveServices get instance => _instance ??= HiveServices._();

  // HiveServices._();

  hiveService() async {
    await Hive.initFlutter();
    WidgetsFlutterBinding.ensureInitialized();
    Hive.registerAdapter(CustomContactModelAdapter());
    Hive.registerAdapter(ItemModelAdapter());
    await Hive.openBox('contactBox');
  }
}
