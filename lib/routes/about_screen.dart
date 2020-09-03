import 'package:commudle/routes/profile_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

class AboutScreen extends StatefulWidget {
  // final about;
  // final imageLink;
  // final name;
  // final webUrl;
  AboutScreen(
      // this.about,
      // this.imageLink,
      // this.name,
      // this.webUrl,
      {
    Key key,
  }) : super(key: key);
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  // String about;
  // String imageLink;
  // String name;
  // String webUrl;
  @override
  void initState() {
    // about = widget.about;
    // imageLink = widget.imageLink;
    // name = widget.name;
    // webUrl = widget.webUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _launchURL(BuildContext context, String value) async {
      final url = value;
      try {
        await launch(
          url,
          option: CustomTabsOption(
            toolbarColor: Theme.of(context).primaryColor,
            enableDefaultShare: true,
            enableUrlBarHiding: true,
            showPageTitle: true,
            // animation: CustomTabsAnimation.slideIn()
            // or user defined animation.
            animation: const CustomTabsAnimation(
              startEnter: 'slide_up',
              startExit: 'android:anim/fade_out',
              endEnter: 'android:anim/fade_in',
              endExit: 'slide_down',
            ),
            extraCustomTabs: const <String>[
              // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
              'org.mozilla.firefox',
              // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
              'com.microsoft.emmx',
            ],
          ),
        );
      } catch (e) {
        // An exception is thrown if browser app is not installed on Android device.
        debugPrint(e.toString());
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    left: 16.0, top: 48.0, bottom: 16.0, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        IconData(58848,
                            fontFamily: 'MaterialIcons',
                            matchTextDirection: true),
                        color: const Color(0xFF707070),
                        size: 20.0,
                      ),
                    ),
                    Text(
                      'About',
                      style: Theme.of(context).textTheme.headline,
                    ),
                    InkWell(
                      child: Icon(
                        const IconData(59389, fontFamily: 'MaterialIcons'),
                        color: const Color(0xFF707070),
                        size: 24.0,
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
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      child: Image(
                        image: AssetImage('assets/images/temp-wtm.png'),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.only(left: 12.0),
                        child: Text(
                          'Developer student clubs KIET',
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'GDG New Delhi provides a network for people who are interested in Google\'s open source technologies and also love the spirit of sharing in the field of technology. A group of developers that foster learning of Google’s developer technologies. We organize CodeLabs, tech talks, hackathons, Extended events, devFests, and study jams. The group is free to attend and open to all who are interested in discussing and learning more about software development with tools and technologies from Google or the open-source community. Disclaimer: GDG New Delhi is an independent group; our activities and the opinions expressed here should in no way be linked to Google, the corporation. To learn more about the GDG program, visit https://developers.google.com/groups/',
                      style: Theme.of(context).textTheme.body1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Web Url:  ',
                          style: Theme.of(context).textTheme.body1,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _launchURL(context,
                                "https://developers.google.com/groups/"),
                            child: Text(
                              "https://developers.google.com/groups/",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 16.0,
                                fontFamily: 'Product Sans',
                                fontWeight: FontWeight.w400,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
