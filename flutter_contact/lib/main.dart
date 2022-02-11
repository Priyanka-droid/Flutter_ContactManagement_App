import 'package:flutter/material.dart';
import 'package:flutter_contact/contact_management_provider.dart';
import 'package:flutter_contact/models/custom_model.dart' as model;
import 'package:flutter_contact/models/custom_model.dart';
import 'package:flutter_contact/screens/home_screen/views/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'models/item_model.dart';

void main() async {
  // final appDocumentDirectory =
  //     await path_provider.getApplicationDocumentsDirectory();
  // Hive.registerAdapter(ContactModelAdapter());
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(CustomContactModelAdapter());
  Hive.registerAdapter(ItemModelAdapter());

  await Hive.openBox('contactBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContactListProvider>(
        create: (context) => ContactListProvider(),
        child: MaterialApp(
            title: 'Contact Management App', home: ContactManagement()));
  }
}
