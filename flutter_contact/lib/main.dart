import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contact/contact_management_provider.dart';
import 'package:flutter_contact/screens/home_screen/views/home_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/widgets/navigator.dart';

void main() {
  runApp(ChangeNotifierProvider<ContactListProvider>(
      create: (context) => ContactListProvider(),
      child: MaterialApp(
          title: 'Contact Management App', home: ContactManagement())));
}
