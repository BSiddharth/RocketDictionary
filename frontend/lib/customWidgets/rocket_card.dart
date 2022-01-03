import 'package:hive_flutter/hive_flutter.dart';
import 'package:rocketdictionary/const.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rocketdictionary/customWidgets/card_cached_network_main_image.dart';
import 'package:rocketdictionary/customWidgets/custom_icon_button.dart';
import 'package:rocketdictionary/models/rocket.dart';
import 'package:rocketdictionary/providers.dart';
import 'package:flutter/material.dart';
import 'package:rocketdictionary/customWidgets/round_cached_network_image.dart';
import 'package:rocketdictionary/screens/card_detailed.dart';

class RocketCard extends ConsumerStatefulWidget {
  final String mainImageUrl;
  final String rocketName;
  final String rocketManufacturerName;
  final String rocketStatus;
  final String countryImageUrl;
  final String rocketType;
  final String rocketCPL;
  final String summary;
  final String id;
  final List content;
  final List images;
  final bool isBookmarked;
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
    required this.id,
    required this.content,
    required this.images,
    required this.isBookmarked,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RocketCardState();
}

class _RocketCardState extends ConsumerState<RocketCard> {
  late bool isBookmarked = widget.isBookmarked;
  @override
  Widget build(BuildContext context) {
    final isLightTheme = ref.watch(lightModeActivatedStateProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, CardDetailed.name, arguments: {
            'rocketName': widget.rocketName,
            'summary': widget.summary,
            'content': widget.content,
            'images': widget.images,
          });
        },
        child: Container(
          width: double.infinity,
          height: 340,
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
                child: Column(
                  children: [
                    Expanded(
                      child: CardCachedNetworkMainImage(
                        url: widget.mainImageUrl,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: const BorderRadius.only(
                          // topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomIconButton(
                              iconSize: 20,
                              onPressed: () {},
                              icon: const Icon(Icons.share)),
                          CustomIconButton(
                              iconSize: 20,
                              onPressed: () async {
                                final bookmarks = Hive.box('bookMarks');

                                if (isBookmarked) {
                                  bookmarks.delete(widget.id);
                                } else {
                                  final rocket = Rocket(
                                    content: widget.content,
                                    images: widget.images,
                                    countryImageUrl: widget.countryImageUrl,
                                    rocketCPL: widget.rocketCPL,
                                    rocketStatus: widget.rocketStatus,
                                    rocketType: widget.rocketType,
                                    mainImageUrl: widget.mainImageUrl,
                                    rocketManufacturerName:
                                        widget.rocketManufacturerName,
                                    rocketName: widget.rocketName,
                                    summary: widget.summary,
                                    isBookmarked: true,
                                    id: widget.id,
                                  );
                                  bookmarks.put(widget.id, rocket);
                                }
                                setState(() {
                                  isBookmarked = !isBookmarked;
                                });
                              },
                              icon: isBookmarked
                                  ? const Icon(Icons.bookmark_rounded)
                                  : const Icon(Icons.bookmark_border_rounded)),
                        ],
                      ),
                    )
                  ],
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
                                  data: widget.rocketName,
                                ),
                              ),
                              Expanded(
                                child: RocketCardInfoBlock(
                                  title: 'Manufacturer',
                                  data: widget.rocketManufacturerName,
                                ),
                              ),
                              Expanded(
                                child: RocketCardInfoBlock(
                                  title: 'Status',
                                  data: widget.rocketStatus,
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
                                  data: widget.countryImageUrl,
                                  isImage: true,
                                ),
                              ),
                              Expanded(
                                child: RocketCardInfoBlock(
                                  title: 'Type',
                                  data: widget.rocketType,
                                ),
                              ),
                              Expanded(
                                child: RocketCardInfoBlock(
                                  title: 'Cost per Launch',
                                  data: widget.rocketCPL,
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
