import 'package:flutter/material.dart';
import 'package:flutter_contact/hive_services.dart';
import 'package:flutter_contact/screens/home_screen/views/myapp.dart';

void main() async {
  await HiveServices.instance.hiveService();
  runApp(MyApp());
}
