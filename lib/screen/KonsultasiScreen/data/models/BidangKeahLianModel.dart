/// id : "1"
/// nama : "Arsitek"
/// create_at : "2020-11-29 21:58:03.978934"
/// aktif : "1"
/// icon : "icon.png"

class BidangKeahLianModel {
  String _id;
  String _nama;
  String _createAt;
  String _aktif;
  String _icon;

  String get id => _id;
  String get nama => _nama;
  String get createAt => _createAt;
  String get aktif => _aktif;
  String get icon => _icon;

  BidangKeahLianModel({
      String id, 
      String nama, 
      String createAt, 
      String aktif, 
      String icon}){
    _id = id;
    _nama = nama;
    _createAt = createAt;
    _aktif = aktif;
    _icon = icon;
}

  BidangKeahLianModel.fromJson(dynamic json) {
    _id = json["id"];
    _nama = json["nama"];
    _createAt = json["create_at"];
    _aktif = json["aktif"];
    _icon = json["icon"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["nama"] = _nama;
    map["create_at"] = _createAt;
    map["aktif"] = _aktif;
    map["icon"] = _icon;
    return map;
  }

}