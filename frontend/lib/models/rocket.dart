class Rocket {
  final String? mainImageUrl;
  final String? rocketName;
  final String? rocketManufacturerName;
  final String? rocketStatus;
  final String? countryImageUrl;
  final String? rocketType;
  final String? rocketCPL;
  final List content;
  final List images;
  final String? summary;
  const Rocket({
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
  });
}
