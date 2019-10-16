import 'package:commudle/widgets/cards/next_event_card.dart';
import 'package:flutter/material.dart';

class NextEventWidget extends StatefulWidget {
  @override
  _NextEventWidgetState createState() => _NextEventWidgetState();
}

class _NextEventWidgetState extends State<NextEventWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "My next event",
                style: Theme.of(context).textTheme.title,
              ),
              GestureDetector(
                  onTap: navigationPage,
                  child: Text(
                    "Registered Events",
                    style: TextStyle(
                        fontSize: 14.0,
                        color: const Color(0xFF0F9D58),
                        fontWeight: FontWeight.w600),
                  ))
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
          ),
          child: Container(
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[
                NextEventCard(),
                NextEventCard(),
                NextEventCard(),
              ],
            ),
          ),
        )
      ],
    );
  }

  void navigationPage() {
    Navigator.pushNamed(context, '/RegisteredEventScreen');
  }
}
