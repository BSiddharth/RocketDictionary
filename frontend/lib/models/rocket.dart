import 'package:hive/hive.dart';

part 'rocket.g.dart';

@HiveType(typeId: 0)
class Rocket extends HiveObject {
  @HiveField(0)
  final String? mainImageUrl;
  @HiveField(1)
  final String? rocketName;
  @HiveField(2)
  final String? rocketManufacturerName;
  @HiveField(3)
  final String? rocketStatus;
  @HiveField(4)
  final String? countryImageUrl;
  @HiveField(5)
  final String? rocketType;
  @HiveField(6)
  final String? rocketCPL;
  @HiveField(7)
  final List content;
  @HiveField(8)
  final List images;
  @HiveField(9)
  final String? summary;
  @HiveField(10)
  final bool isBookmarked;
  @HiveField(11)
  final String id;
  Rocket({
    required this.mainImageUrl,
    required this.rocketName,
    required this.rocketManufacturerName,
    required this.rocketStatus,
    required this.countryImageUrl,
    required this.rocketType,
    required this.rocketCPL,
    required this.content,
    required this.images,
    required this.summary,
    required this.isBookmarked,
    required this.id,
  });
}
