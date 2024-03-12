// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CityDataModelAdapter extends TypeAdapter<CityDataModel> {
  @override
  final int typeId = 0;

  @override
  CityDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CityDataModel(
      name: fields[0] as String,
      lat: fields[1] as double,
      long: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CityDataModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.lat)
      ..writeByte(2)
      ..write(obj.long);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CityDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
