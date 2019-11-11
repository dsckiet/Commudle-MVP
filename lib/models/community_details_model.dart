class CommunityDetails {
  Data data;
  String message;
  int status;

  CommunityDetails({this.data, this.message, this.status});

  CommunityDetails.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  Community community;

  Data({this.community});

  Data.fromJson(Map<String, dynamic> json) {
    community = json['community'] != null
        ? new Community.fromJson(json['community'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.community != null) {
      data['community'] = this.community.toJson();
    }
    return data;
  }
}

class Community {
  InData data;

  Community({this.data});

  Community.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new InData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class InData {
  String id;
  String type;
  Attributes attributes;
  Links links;

  InData({this.id, this.type, this.attributes, this.links});

  InData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    if (this.attributes != null) {
      data['attributes'] = this.attributes.toJson();
    }
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    return data;
  }
}

class Attributes {
  String name;
  String logoPath;
  String miniDescription;
  String contactEmail;
  int memberCount;
  String about;

  Attributes(
      {this.name,
      this.logoPath,
      this.miniDescription,
      this.contactEmail,
      this.memberCount,
      this.about});

  Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    logoPath = json['logo_path'];
    miniDescription = json['mini_description'];
    contactEmail = json['contact_email'];
    memberCount = json['member_count'];
    about = json['about'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['logo_path'] = this.logoPath;
    data['mini_description'] = this.miniDescription;
    data['contact_email'] = this.contactEmail;
    data['member_count'] = this.memberCount;
    data['about'] = this.about;
    return data;
  }
}

class Links {
  String apiUrl;
  String webUrl;
  String upcomingEventsUrl;
  String pastEventsUrl;

  Links({this.apiUrl, this.webUrl, this.upcomingEventsUrl, this.pastEventsUrl});

  Links.fromJson(Map<String, dynamic> json) {
    apiUrl = json['api_url'];
    webUrl = json['web_url'];
    upcomingEventsUrl = json['upcoming_events_url'];
    pastEventsUrl = json['past_events_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_url'] = this.apiUrl;
    data['web_url'] = this.webUrl;
    data['upcoming_events_url'] = this.upcomingEventsUrl;
    data['past_events_url'] = this.pastEventsUrl;
    return data;
  }
}