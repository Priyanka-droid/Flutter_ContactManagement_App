import 'package:hive/hive.dart';

part 'item_model.g.dart';

// custom model for phone

@HiveType(typeId: 2)
class ItemModel {
  @HiveField(0)
  String? label;
  @HiveField(1)
  String? value;
  ItemModel({this.label, this.value});
}
