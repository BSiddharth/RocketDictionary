import 'package:flutter/material.dart';
import 'package:rocketdictionary/const.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rocketdictionary/customWidgets/card_cached_network_main_image.dart';
import 'package:rocketdictionary/customWidgets/round_cached_network_image.dart';
import 'package:rocketdictionary/customWidgets/scroll_glow_remover.dart';
import 'package:rocketdictionary/providers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollGlowRemover(
      child: ListView(
        children: const [
          RocketCard(
            mainImageUrl:
                'https://upload.wikimedia.org/wikipedia/commons/9/9a/Soyuz_TMA-9_launch.jpgg',
            rocketName: 'Soyuz',
            rocketManufacturerName: 'Korolev Design Bureau',
            rocketStatus: 'Active',
            countryImageUrl:
                'https://cdn.britannica.com/42/3842-004-F47B77BC/Flag-Russia.jpgg',
            rocketType: 'MLV',
            rocketCPL: '\$35 M',
          )
        ],
      ),
    );
  }
}

// class RocketCard extends StatelessWidget {
//   const RocketCard({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.pushNamed(context, CardDetailed.name);
//       },
//       child: Consumer(
//         builder: (context, ref, child) {
//           final isLightTheme = ref.watch(lightModeActivatedStateProvider);
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//             child: Container(
//               decoration: isLightTheme
//                   ? const BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey,
//                           blurRadius: 10,
//                           offset: Offset(0, 5),
//                         ),
//                       ],
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(12),
//                       ),
//                     )
//                   : null,
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       height: 300,
//                       decoration: const BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage('assets/images/soyuz.jpg'),
//                           fit: BoxFit.cover,
//                         ),
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(12),
//                           bottomLeft: Radius.circular(12),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 2,
//                     child: Container(
//                       height: 300,
//                       decoration: BoxDecoration(
//                         color: isLightTheme
//                             ? Colors.white
//                             : kDarkModeSupportBlackishGrey,
//                         // color: kDarkModeSupportBlackishGrey,
//                         borderRadius: const BorderRadius.only(
//                           topRight: Radius.circular(12),
//                           bottomRight: Radius.circular(12),
//                         ),
//                       ),
//                       child: const RocketCardInfo(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class RocketCardInfo extends StatelessWidget {
//   const RocketCardInfo({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: const [
//             RocketCardInfoBlock(title: 'Name', body: 'Soyuz'),
//             RocketCardInfoBlock(
//               title: 'Country of origin',
//               body: 'Soviet Union',
//               isImage: true,
//             ),
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: const [
//             RocketCardInfoBlock(
//                 title: 'Manufacturer', body: 'Korolev Design Bureau'),
//             RocketCardInfoBlock(title: 'Type', body: 'MLV'),
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: const [
//             RocketCardInfoBlock(title: 'Status', body: 'In service'),
//             RocketCardInfoBlock(title: 'Cost per Launch', body: '\$35 M'),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class RocketCardInfoBlock extends StatelessWidget {
//   final String body;
//   final String title;
//   final bool isImage;
//   const RocketCardInfoBlock(
//       {Key? key, required this.title, required this.body, this.isImage = false})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisSize: MainAxisSize.max,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         isImage
//             ? const CircleAvatar(
//                 radius: 18,
//                 backgroundImage: AssetImage('assets/images/russiaFlag.png'),
//               )
//             : Text(
//                 body,
//                 // style: const TextStyle(color: Colors.black),
//                 // style: const TextStyle(color: Colors.white),
//                 textAlign: TextAlign.center,
//               ),
//         Text(
//           title,
//           style:
//               const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }
// }

class RocketCard extends ConsumerWidget {
  final String mainImageUrl;
  final String rocketName;
  final String rocketManufacturerName;
  final String rocketStatus;
  final String countryImageUrl;
  final String rocketType;
  final String rocketCPL;
  const RocketCard({
    Key? key,
    required this.mainImageUrl,
    required this.rocketName,
    required this.rocketManufacturerName,
    required this.rocketStatus,
    required this.countryImageUrl,
    required this.rocketType,
    required this.rocketCPL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLightTheme = ref.watch(lightModeActivatedStateProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
