// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rocket.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RocketAdapter extends TypeAdapter<Rocket> {
  @override
  final int typeId = 0;

  @override
  Rocket read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Rocket(
      mainImageUrl: fields[0] as String?,
      rocketName: fields[1] as String?,
      rocketManufacturerName: fields[2] as String?,
      rocketStatus: fields[3] as String?,
      countryImageUrl: fields[4] as String?,
      rocketType: fields[5] as String?,
      rocketCPL: fields[6] as String?,
      content: (fields[7] as List).cast<dynamic>(),
      images: (fields[8] as List).cast<dynamic>(),
      summary: fields[9] as String?,
      isBookmarked: fields[10] as bool,
      id: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Rocket obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.mainImageUrl)
      ..writeByte(1)
      ..write(obj.rocketName)
      ..writeByte(2)
      ..write(obj.rocketManufacturerName)
      ..writeByte(3)
      ..write(obj.rocketStatus)
      ..writeByte(4)
      ..write(obj.countryImageUrl)
      ..writeByte(5)
      ..write(obj.rocketType)
      ..writeByte(6)
      ..write(obj.rocketCPL)
      ..writeByte(7)
      ..write(obj.content)
      ..writeByte(8)
      ..write(obj.images)
      ..writeByte(9)
      ..write(obj.summary)
      ..writeByte(10)
      ..write(obj.isBookmarked)
      ..writeByte(11)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RocketAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
