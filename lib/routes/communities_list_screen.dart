import 'package:commudle/models/communities_model.dart';
import 'package:commudle/providers/communities_providers.dart';
import 'package:commudle/routes/community_screen.dart';
import 'package:commudle/routes/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommunitiesListScreen extends StatefulWidget {
  @override
  _CommunitiesListScreenState createState() => _CommunitiesListScreenState();
}

class _CommunitiesListScreenState extends State<CommunitiesListScreen> {
  bool _isInit = true;
  bool _isLoading = false;
  bool _isDataAvl = false;
  String _errorMsg;
  List<CommunitiesModel> _communities = [];

  void didChangeDependencies() async {
    if (_isInit) {
      setState(
        () {
          _isLoading = true;
        },
      );
      try {
        await Provider.of<CommunitiesProviders>(context)
            .viewCommunities(context)
            .then(
          (_) {
            setState(
              () {
                _communities =
                    Provider.of<CommunitiesProviders>(context).communitiesData;
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
  void initState() {
    _isInit = true;
    _isLoading = false;
    _isDataAvl = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
        // WillPopScope(
        //   onWillPop: () {
        //     return new Future.value(true);
        //   },
        //   child:
        Scaffold(
      body:
          // SingleChildScrollView(
          Column(
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
                        fontFamily: 'MaterialIcons', matchTextDirection: true),
                    color: const Color(0xFF707070),
                  ),
                ),
                Text(
                  'Communities',
                  style: Theme.of(context).textTheme.headline,
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
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
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
                  : Container(
                      // margin: EdgeInsets.only(bottom: 16.0),
                      child: Consumer<CommunitiesProviders>(
                        builder: (_, commudata, ch) => Expanded(
                          child: ListView.builder(
                            itemCount: _communities.length,
                            //shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CommunityScreen(
                                            _communities[index]
                                                .data
                                                .links
                                                .apiUrl),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 4.0),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0))),
                                      color: const Color(0xFFF9F9F9),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 8.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  child: Image.network(
                                                    '${_communities[index].data.attributes.logoPath}',
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 12,
                                                ),
                                                Container(
                                                  // padding: EdgeInsets.only(
                                                  //     left: 12.0),
                                                  child: Expanded(
                                                    child: Text(
                                                      "${_communities[index].data.attributes.name}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .title,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(top: 12.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  // Row(
                                                  //   children: <Widget>[
                                                  //     Icon(
                                                  //       const IconData(58900,
                                                  //           fontFamily:
                                                  //               'MaterialIcons'),
                                                  //       color: const Color(
                                                  //           0xFF707070),
                                                  //     ),
                                                  //     Text(
                                                  //       'Events Count: 8',
                                                  //       style: Theme.of(context)
                                                  //           .textTheme
                                                  //           .body1,
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                  // Row(
                                                  //   children: <Widget>[
                                                  //     Icon(
                                                  //       const IconData(59603,
                                                  //           fontFamily:
                                                  //               'MaterialIcons'),
                                                  //       color: const Color(
                                                  //           0xFF707070),
                                                  //     ),
                                                  //     Text(
                                                  //       'Members: 5',
                                                  //       style: Theme.of(context)
                                                  //           .textTheme
                                                  //           .body1,
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                  Expanded(
                                                    child: Text(
                                                      '${_communities[index].data.attributes.miniDescription}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .body1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
        ],
      ),
      // ),
      // ),
    );
  }
}
