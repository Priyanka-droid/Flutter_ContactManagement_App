// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomContactModelAdapter extends TypeAdapter<CustomContactModel> {
  @override
  final int typeId = 1;

  @override
  CustomContactModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomContactModel(
      givenName: fields[0] as String,
      phone: fields[1] as ItemModel,
      avatar: fields[2] as Uint8List?,
    );
  }

  @override
  void write(BinaryWriter writer, CustomContactModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.givenName)
      ..writeByte(1)
      ..write(obj.phone)
      ..writeByte(2)
      ..write(obj.avatar);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomContactModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
