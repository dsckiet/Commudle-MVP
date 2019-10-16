import 'package:commudle/models/communities_model.dart';
import 'package:commudle/providers/communities_providers.dart';
import 'package:flutter/material.dart';

import 'package:commudle/routes/community_screen.dart';
import 'package:commudle/widgets/cards/community_card.dart';
import 'package:provider/provider.dart';

class CommunitiesWidget extends StatefulWidget {
  @override
  _CommunitiesWidgetState createState() => _CommunitiesWidgetState();
}

class _CommunitiesWidgetState extends State<CommunitiesWidget> {
  bool _isInit = true;
  bool _isLoading = false;
  List<CommunitiesModel> _communities = [];

  void didChangeDependencies() async {
    if (_isInit) {
      setState(
        () {
          _isLoading = true;
        },
      );
      await Provider.of<CommunitiesProviders>(context)
          .viewCommunities(context)
          .then(
        (_) {
          setState(
            () {
              _communities =
                  Provider.of<CommunitiesProviders>(context).communitiesData;
              _isLoading = false;
              //print(json.decode(_communities);
            },
          );
        },
      );
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _isInit = true;
    _isLoading = false;
    super.initState();
  }

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
                "Communities",
                style: Theme.of(context).textTheme.title,
              ),
              GestureDetector(
                onTap: navigationPage,
                child: Text(
                  "See All",
                  style: TextStyle(
                      fontSize: 14.0,
                      color: const Color(0xFFDB4437),
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            height: 100.0,
            child: Container(
              child: Consumer<CommunitiesProviders>(
                builder: (_, commudata, ch) => ListView.builder(
                  itemCount: _communities.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(left: 18.0),
                      child: InkWell(
                        child: FittedBox(
                          child: Container(
                            padding:
                                EdgeInsets.only(bottom: 8, left: 2, right: 2),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              color: const Color(0xFFF9F9F9),
                              elevation: 6.0,
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: 50,
                                      height: 50,
                                      child: Image.network(
                                        '${_communities[index].data.attributes.logoPath}',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        "${_communities[index].data.attributes.name}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: const Color(0xFF707070),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CommunityScreen()),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void navigationPage() {
    Navigator.pushNamed(context, '/CommunitiesListScreen');
  }
}
