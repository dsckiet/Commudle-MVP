import 'package:commudle/models/communities_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class CommunitiesProviders with ChangeNotifier {
  static const url = "https://commudle.com/api/v1/communities";

  List<CommunitiesModel> _communitiesData;

  List<CommunitiesModel> get communitiesData {
    return [..._communitiesData];
  }

  Future<void> viewCommunities(context) async {
    try {
      final response = await http.get(
        url,
      );

      final extractedData = json.decode(response.body);
      print(json.decode(response.body));

      // Map<String,dynamic> _loadedData = (extractedData['data']);

      List<CommunitiesModel> _loadedCommunitiesData = [];
      _loadedCommunitiesData = (extractedData['data']['communities'] as List)
          .map((i) => CommunitiesModel.fromJson(i))
          .toList();

      print(_loadedCommunitiesData.toString());
      _communitiesData = _loadedCommunitiesData;
      notifyListeners();
    } on NoSuchMethodError {} catch (error) {
      print(error.toString());
      throw (error);
    }
  }
}
