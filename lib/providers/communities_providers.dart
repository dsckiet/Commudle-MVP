import 'package:commudle/models/communities_model.dart';
import 'package:commudle/models/community_details_model.dart';
import 'package:commudle/widgets/show_dialog.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class CommunitiesProviders with ChangeNotifier {
  static const url = "https://commudle.com/api/v1/communities";

  bool _isDataAvl;
  String _errorMsg;
  List<CommunitiesModel> _communitiesData;
  List<String> _apiUrls = [];
  CommunityDetails _communityDetails;

  bool get isDataAvl {
    return _isDataAvl;
  }

  String get errorMsg {
    return _errorMsg;
  }

  List<CommunitiesModel> get communitiesData {
    return [..._communitiesData];
  }

  CommunityDetails get communityDetails {
    return _communityDetails;
  }

  Future<void> viewCommunities(context) async {
    try {
      final response = await http.get(
        url,
      );

      final extractedData = json.decode(response.body);
      //print(json.decode(response.body));

      List<CommunitiesModel> _loadedCommunitiesData = [];
      _loadedCommunitiesData = (extractedData['data']['communities'] as List)
          .map((i) => CommunitiesModel.fromJson(i))
          .toList();

      _communitiesData = _loadedCommunitiesData;
      print(_loadedCommunitiesData.toString());
      notifyListeners();
    } on NoSuchMethodError {
      _isDataAvl = false;
    } on SocketException {
      // Navigator.of(context).push(
      //      MaterialPageRoute(builder: (context) => NetworkErrorPage()));
      ShowDialog().showErrorDialogNetwork(context);
    } catch (error) {
      print(error.toString());
      throw (error);
    }
  }

  Future<void> communitiesApiUrl(String apiUrl) async {
    final url = apiUrl;
    try {
      final response = await http.get(
        url,
      );

      final extractedData = json.decode(response.body);
      //print(json.decode(response.body));

      _communityDetails = CommunityDetails.fromJson(extractedData);
      print(_communityDetails.toString());

      notifyListeners();
    } on NoSuchMethodError {
      _isDataAvl = false;
      // } on SocketException {
      //   // Navigator.of(context).push(
      //   //      MaterialPageRoute(builder: (context) => NetworkErrorPage()));
      //   ShowDialog().showErrorDialogNetwork(context);
      //
    } catch (error) {
      print(error.toString());
      //throw (error);
    }
  }
}
