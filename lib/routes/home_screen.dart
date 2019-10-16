import 'package:flutter/material.dart';

import 'package:commudle/routes/profile_screen.dart';
import 'package:commudle/widgets/communities_widget.dart';
import 'package:commudle/widgets/next_event_widget.dart';
import 'package:commudle/widgets/upcoming_events_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return new Future.value(true);
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, top: 48.0, bottom: 16.0, right: 20.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                        ),
                        Expanded(
                          child: Text(
                            "Home",
                            style: Theme.of(context).textTheme.headline,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        InkWell(
                          child: Icon(
                            const IconData(59389, fontFamily: 'MaterialIcons'),
                            color: const Color(0xFF707070),
                            size: 28.0,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileScreen()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: CommunitiesWidget(),
                  ),
                  Container(
                    child: NextEventWidget(),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: UpcomingEventsWidget(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
