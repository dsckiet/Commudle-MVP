import 'package:flutter/foundation.dart';

// class CommunitiesModel with ChangeNotifier {
//   List<Communities> communities;

//   CommunitiesModel({this.communities});

//   CommunitiesModel.fromJson(Map<String, dynamic> json) {
//     if (json['communities'] != null) {
//       communities = new List<Communities>();
//       json['communities'].forEach((v) {
//         communities.add(new Communities.fromJson(v));
//       });
//     }
//   }
// }

class CommunitiesModel {
  Data data;

  CommunitiesModel({this.data});

  CommunitiesModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  String id;
  String type;
  Attributes attributes;
  Links links;

  Data({this.id, this.type, this.attributes, this.links});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }
}

class Attributes {
  String name;
  String logoPath;
  String miniDescription;
  String contactEmail;
  String about;

  Attributes(
      {this.name,
      this.logoPath,
      this.miniDescription,
      this.contactEmail,
      this.about});

  Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    logoPath = json['logo_path'];
    miniDescription = json['mini_description'];
    contactEmail = json['contact_email'];
    about = json['about'];
  }
}

class Links {
  String apiUrl;
  String webUrl;

  Links({this.apiUrl, this.webUrl});

  Links.fromJson(Map<String, dynamic> json) {
    apiUrl = json['api_url'];
    webUrl = json['web_url'];
  }
}
