import 'package:flutter/material.dart';
import 'package:flutter_contact/contact_management_provider.dart';
import 'package:flutter_contact/hive_services.dart';
import 'package:flutter_contact/screens/home_screen/views/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  await HiveServices().hiveService();
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
