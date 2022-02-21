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
      firstName: fields[0] as String,
      lastName: fields[1] as String,
      phone: fields[2] as ItemModel,
      avatar: fields[3] as Uint8List?,
    );
  }

  @override
  void write(BinaryWriter writer, CustomContactModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
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
