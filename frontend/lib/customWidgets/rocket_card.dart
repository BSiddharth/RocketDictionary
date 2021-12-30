import 'package:rocketdictionary/const.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rocketdictionary/customWidgets/card_cached_network_main_image.dart';
import 'package:rocketdictionary/providers.dart';
import 'package:flutter/material.dart';
import 'package:rocketdictionary/customWidgets/round_cached_network_image.dart';
import 'package:rocketdictionary/screens/cardDetailedScreens/card_detailed.dart';

class RocketCard extends ConsumerWidget {
  final String mainImageUrl;
  final String rocketName;
  final String rocketManufacturerName;
  final String rocketStatus;
  final String countryImageUrl;
  final String rocketType;
  final String rocketCPL;
  final String summary;
  final List content;
  final List images;
  const RocketCard({
    Key? key,
    required this.mainImageUrl,
    required this.rocketName,
    required this.rocketManufacturerName,
    required this.rocketStatus,
    required this.countryImageUrl,
    required this.rocketType,
    required this.rocketCPL,
    required this.summary,
    required this.content,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLightTheme = ref.watch(lightModeActivatedStateProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, CardDetailed.name, arguments: {
            'rocketName': rocketName,
            'summary': summary,
            'content': content,
            'images': images,
          });
        },
        child: Container(
          width: double.infinity,
          height: 300,
          decoration: isLightTheme
              ? const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                )
              : null,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: CardCachedNetworkMainImage(
                  url: mainImageUrl,
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      color: isLightTheme
                          ? Colors.white
                          : kDarkModeSupportBlackishGrey,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: RocketCardInfoBlock(
                                  title: 'Name',
                                  data: rocketName,
                                ),
                              ),
                              Expanded(
                                child: RocketCardInfoBlock(
                                  title: 'Manufacturer',
                                  data: rocketManufacturerName,
                                ),
                              ),
                              Expanded(
                                child: RocketCardInfoBlock(
                                  title: 'Status',
                                  data: rocketStatus,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: RocketCardInfoBlock(
                                  title: 'Country of origin',
                                  data: countryImageUrl,
                                  isImage: true,
                                ),
                              ),
                              Expanded(
                                child: RocketCardInfoBlock(
                                  title: 'Type',
                                  data: rocketType,
                                ),
                              ),
                              Expanded(
                                child: RocketCardInfoBlock(
                                  title: 'Cost per Launch',
                                  data: rocketCPL,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class RocketCardInfoBlock extends StatelessWidget {
  final String title;
  final String data;
  final bool isImage;
  const RocketCardInfoBlock({
    Key? key,
    required this.title,
    required this.data,
    this.isImage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        isImage
            ? RoundCachedNetworkImage(url: data, dimension: 35)
            : Text(
                data,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
        const SizedBox(height: 10),
        Text(
          title,
          style:
              const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
