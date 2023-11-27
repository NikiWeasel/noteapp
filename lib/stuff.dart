class Users {
  int? id;
  String? username;
  String? email;
  String? password;
  List<StuffList>? stuffList;

  Users(
      {this.id, this.username, this.email, this.password, this.stuffList});
  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    if (json['stuff_list'] != null) {
      stuffList = <StuffList>[];
      json['stuff_list'].forEach((v) {
        stuffList!.add(StuffList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    if (stuffList != null) {
      data['stuff_list'] = stuffList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StuffList {
  String? name;
  String? info;
  String? date;
  String? photo;

  StuffList({this.name, this.info, this.date, this.photo});

  StuffList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    info = json['info'];
    date = json['date'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['info'] = info;
    data['date'] = date;
    data['photo'] = photo;
    return data;
  }
}







