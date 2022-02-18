import 'package:flutter/material.dart';
import 'package:flutter_contact/screens/home_screen/views/contact_management_home_page.dart';
import 'package:provider/provider.dart';

import '../../../contact_management_provider.dart';

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
