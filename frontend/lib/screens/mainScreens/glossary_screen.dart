import 'package:flutter/material.dart';
import 'package:rocketdictionary/customWidgets/scroll_glow_remover.dart';

class GlossaryScreen extends StatelessWidget {
  const GlossaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollGlowRemover(
      child: ListView(
        children: const [
          Heading(heading: 'A'),
          CollapsibleGlossaryCard(),
          CollapsibleGlossaryCard(),
          CollapsibleGlossaryCard(),
          CollapsibleGlossaryCard(),
          CollapsibleGlossaryCard(),
          Heading(heading: 'B'),
          CollapsibleGlossaryCard(),
          CollapsibleGlossaryCard(),
          CollapsibleGlossaryCard(),
          CollapsibleGlossaryCard(),
          CollapsibleGlossaryCard(),
        ],
      ),
    );
  }
}

class Heading extends StatelessWidget {
  const Heading({Key? key, required this.heading}) : super(key: key);
  final String heading;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: const TextStyle(fontSize: 18),
          ),
          Container(
            color: Colors.grey,
            height: 1,
          ),
        ],
      ),
    );
  }
}

class CollapsibleGlossaryCard extends StatelessWidget {
  const CollapsibleGlossaryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 5.0,
      ),
      child: Card(
        // color: kDarkModeSupportBlackishGrey,
        margin: EdgeInsets.zero,
        child: ExpansionTile(
          iconColor: Colors.grey,
          collapsedIconColor: Colors.grey,
          title: Text('ExpansionTile 1'),
          subtitle: Text('Trailing expansion arrow icon'),
          children: <Widget>[
            ListTile(title: Text('This is tile number 1')),
          ],
        ),
      ),
    );
  }
}
