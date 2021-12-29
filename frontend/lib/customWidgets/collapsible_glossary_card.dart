import 'package:flutter/material.dart';

class CollapsibleGlossaryCard extends StatelessWidget {
  final String name;
  final String description;
  const CollapsibleGlossaryCard(
      {Key? key, required this.name, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 5.0,
      ),
      child: Card(
        // color: kDarkModeSupportBlackishGrey,
        margin: EdgeInsets.zero,
        child: ExpansionTile(
          textColor: Theme.of(context).textTheme.bodyText1!.color,
          iconColor: Colors.grey,
          collapsedIconColor: Colors.grey,
          title: Text(name),
          children: <Widget>[
            ListTile(title: Text(description)),
          ],
        ),
      ),
    );
  }
}
