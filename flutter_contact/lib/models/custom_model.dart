import 'dart:typed_data';
import 'package:flutter_contact/models/item_model.dart';
import 'package:hive/hive.dart';
import 'item_model.dart' as item;
part 'custom_model.g.dart';

// custom model for contact app

@HiveType(typeId: 1)
class CustomContactModel {
  @HiveField(0)
  String givenName;
  @HiveField(1)
  item.ItemModel phone;
  @HiveField(2)
  Uint8List? avatar;
  CustomContactModel(
      {required this.givenName, required this.phone, this.avatar});
}
