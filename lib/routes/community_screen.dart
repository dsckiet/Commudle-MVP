import 'package:commudle/models/community_details_model.dart';
import 'package:commudle/routes/about_screen.dart';
import 'package:commudle/routes/events_screen.dart';
import 'package:commudle/routes/profile_screen.dart';
import 'package:commudle/routes/team_screen.dart';
import 'package:commudle/widgets/cards/sessions_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:commudle/providers/communities_providers.dart';

class CommunityScreen extends StatefulWidget {
  final apiLink;
  
  CommunityScreen(
      this.apiLink, {
        Key key,
      }) : super(key: key);
  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  String apiUrl;
  String _errorMsg;
  bool _isInit = true;
  bool _isLoading = false;
  bool _isDataAvl = false;
  CommunityDetails _communityDetails;

  @override
  void initState() {
    apiUrl = widget.apiLink;
    _isInit = true;
    _isLoading = false;
    _isDataAvl = false;
    _communityDetails = new CommunityDetails();
    super.initState();
  }

  void didChangeDependencies() async {
    if (_isInit) {
      setState(
            () {
          _isLoading = true;
        },
      );
      try {
        await Provider.of<CommunitiesProviders>(context)
            .communitiesApiUrl(apiUrl)
            .then(
              (_) {
            setState(
                  () {
                _communityDetails =
                    Provider.of<CommunitiesProviders>(context).communityDetails;
                print(_communityDetails.toString());
                _isDataAvl =
                    Provider.of<CommunitiesProviders>(context).isDataAvl;

                _errorMsg = Provider.of<CommunitiesProviders>(context).errorMsg;

                _isLoading = false;
              },
            );
          },
        );
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Flexible(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            top: 48.0,
                            bottom: 16.0,
                          ),
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
                                ),
                              ),
                              Text(
                                'Community Details',
                                style: Theme.of(context).textTheme.headline,
                              ),
                              InkWell(
                                child: Icon(
                                  const IconData(59389,
                                      fontFamily: 'MaterialIcons'),
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
                        _isLoading
                            ? Center(
                            child: Container(
                                padding: EdgeInsets.all(20),
                                width: 100,
                                height: 100,
                                child: CircularProgressIndicator(
                                  // valueColor:
                                  //     AlwaysStoppedAnimation<Color>(Color(0XFFB4344D)),
                                )))
                            : _isDataAvl == false
                            ? Center(
                          child: Text(
                            'No Data to Show',
                            style: TextStyle(
                              fontSize: 40.0,
                              fontFamily: 'Product Sans',
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF707070),
                            ),
                          ),
                        )
                            : Consumer<CommunitiesProviders>(
                          builder: (_, commudata, ch) => Container(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 60,
                                      height: 60,
                                      child: Image.network(
                                        '${_communityDetails.data.community.data.attributes.logoPath}',
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 12.0),
                                        child: Text(
                                          '${_communityDetails.data.community.data.attributes.name}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .title,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            const IconData(58900,
                                                fontFamily:
                                                'MaterialIcons'),
                                            color: const Color(
                                                0xFF707070),
                                          ),
                                          Text(
                                            'Events Count: 8',
                                            style: Theme.of(context)
                                                .textTheme
                                                .body1,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            const IconData(59603,
                                                fontFamily:
                                                'MaterialIcons'),
                                            color: const Color(
                                                0xFF707070),
                                          ),
                                          Text(
                                            'Members:' +
                                                '${_communityDetails.data.community.data.attributes.memberCount}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .body1,
                                          ),
                                        ],
                                      ),
                                    ]),
                                Container(
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: Text(
                                    'Recent Sessions',
                                    style: Theme.of(context)
                                        .textTheme
                                        .title,
                                  ),
                                ),
                                Container(
                                  padding:
                                  EdgeInsets.only(bottom: 100.0),
                                  child: ListView(
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    children: <Widget>[
                                      SessionsCard(),
                                      SessionsCard(),
                                      SessionsCard(),
                                      SessionsCard(),
                                      SessionsCard(),
                                      SessionsCard(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              ),
              child: Container(
                //height: 70,
                padding: EdgeInsets.only(bottom: 20, left: 20.0, right: 20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ),
                  child: Container(
                    color: Color(0xFF263238),
                    height: 50,
                    padding:
                    EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                    // color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EventsScreen( _communityDetails.data.community
                                                    .data.attributes.logoPath,
                                                _communityDetails.data.community
                                                    .data.attributes.name,)),
                            );
                          },
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  color: Colors.black54,
                                  icon: Icon(
                                    Icons.calendar_today,
                                    color: const Color(0xFFF1F1F1),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EventsScreen( _communityDetails.data.community
                                                    .data.attributes.logoPath,
                                                _communityDetails.data.community
                                                    .data.attributes.name,)),
                                    );
                                  },
                                ),
                                Text(
                                  'Events',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Product Sans',
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFF1F1F1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutScreen(
                                    _communityDetails.data.community.data
                                        .attributes.about,
                                    _communityDetails.data.community.data
                                        .attributes.logoPath,
                                    _communityDetails.data.community.data
                                        .attributes.name,
                                    _communityDetails
                                        .data.community.data.links.webUrl,
                                  )),
                            );
                          },
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  color: Colors.black54,
                                  icon: Icon(
                                    Icons.info_outline,
                                    color: const Color(0xFFF1F1F1),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AboutScreen(
                                            _communityDetails.data.community
                                                .data.attributes.about,
                                            _communityDetails.data.community
                                                .data.attributes.logoPath,
                                            _communityDetails.data.community
                                                .data.attributes.name,
                                            _communityDetails.data.community
                                                .data.links.webUrl,
                                          )),
                                    );
                                  },
                                ),
                                Text(
                                  'About',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'Product Sans',
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFF1F1F1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TeamScreen( _communityDetails.data.community
                                                    .data.attributes.logoPath,
                                                _communityDetails.data.community
                                                    .data.attributes.name,)),
                            );
                          },
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  color: Colors.black54,
                                  icon: Icon(
                                    Icons.contacts,
                                    color: const Color(0xFFF1F1F1),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TeamScreen( _communityDetails.data.community
                                                    .data.attributes.logoPath,
                                                _communityDetails.data.community
                                                    .data.attributes.name,)),
                                    );
                                  },
                                ),
                                Text(
                                  'Team',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'Product Sans',
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFF1F1F1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar:
    );
  }
}