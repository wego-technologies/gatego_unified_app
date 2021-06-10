class Account {
  late int id;
  late String username;
  late bool active;
  late String role;
  String? email;
  late String name;
  String? phoneNumber;
  String? languageCode;
  int? yardId;
  int? carrierId;
  Organization? organization;

  Account({
    required this.id,
    required this.username,
    required this.active,
    required this.role,
    this.email,
    required this.name,
    this.phoneNumber,
    this.languageCode,
    this.yardId,
    this.carrierId,
    this.organization,
  });

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    active = json['active'];
    role = json['role'];
    email = json['email'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    languageCode = json['language_code'];
    yardId = json['yard_id'];
    carrierId = json['carrier_id'];
    organization = json['organization'] != null
        ? new Organization.fromJson(json['organization'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['active'] = this.active;
    data['role'] = this.role;
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['language_code'] = this.languageCode;
    data['yard_id'] = this.yardId;
    data['carrier_id'] = this.carrierId;
    if (this.organization != null) {
      data['organization'] = this.organization!.toJson();
    }
    return data;
  }
}

class Organization {
  late int id;
  late String name;

  Organization({
    required this.id,
    required this.name,
  });

  Organization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
