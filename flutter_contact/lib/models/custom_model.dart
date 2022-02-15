import 'dart:typed_data';
import 'package:flutter_contact/models/item_model.dart';
import 'package:hive/hive.dart';
import 'item_model.dart' as item;
part 'custom_model.g.dart';

// custom model for contact app

@HiveType(typeId: 1)
class CustomContactModel {
  @HiveField(0)
  String firstName;
  @HiveField(1)
  String lastName;
  @HiveField(2)
  item.ItemModel phone;
  @HiveField(3)
  Uint8List? avatar;

  CustomContactModel(
      {required this.firstName,
      required this.lastName,
      required this.phone,
      this.avatar});
}
