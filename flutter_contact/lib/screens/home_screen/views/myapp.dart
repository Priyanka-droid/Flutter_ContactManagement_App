import 'package:flutter/material.dart';
import 'package:flutter_contact/screens/home_screen/views/contact_management_home_page.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../contact_management_provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Contact Management App', home: ContactManagement());
  }
}
