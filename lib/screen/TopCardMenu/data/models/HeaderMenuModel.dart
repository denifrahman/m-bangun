/// id : "1"
/// nama : "Chat dengan Ahli"
/// parent_id : null
/// slug : null
/// icon : "chat-dengan-ahli.png"
/// show_on_homepage : "1"
/// urutan : "1"
/// created_at : null
/// aktif : "1"
/// link : null

class HeaderMenuModel {
  String _id;
  String _nama;
  dynamic _parentId;
  dynamic _slug;
  String _icon;
  String _showOnHomepage;
  String _urutan;
  dynamic _createdAt;
  String _aktif;
  dynamic _link;

  String get id => _id;
  String get nama => _nama;
  dynamic get parentId => _parentId;
  dynamic get slug => _slug;
  String get icon => _icon;
  String get showOnHomepage => _showOnHomepage;
  String get urutan => _urutan;
  dynamic get createdAt => _createdAt;
  String get aktif => _aktif;
  dynamic get link => _link;

  HeaderMenuModel({
      String id, 
      String nama, 
      dynamic parentId, 
      dynamic slug, 
      String icon, 
      String showOnHomepage, 
      String urutan, 
      dynamic createdAt, 
      String aktif, 
      dynamic link}){
    _id = id;
    _nama = nama;
    _parentId = parentId;
    _slug = slug;
    _icon = icon;
    _showOnHomepage = showOnHomepage;
    _urutan = urutan;
    _createdAt = createdAt;
    _aktif = aktif;
    _link = link;
}

  HeaderMenuModel.fromJson(dynamic json) {
    _id = json["id"];
    _nama = json["nama"];
    _parentId = json["parent_id"];
    _slug = json["slug"];
    _icon = json["icon"];
    _showOnHomepage = json["show_on_homepage"];
    _urutan = json["urutan"];
    _createdAt = json["created_at"];
    _aktif = json["aktif"];
    _link = json["link"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["nama"] = _nama;
    map["parent_id"] = _parentId;
    map["slug"] = _slug;
    map["icon"] = _icon;
    map["show_on_homepage"] = _showOnHomepage;
    map["urutan"] = _urutan;
    map["created_at"] = _createdAt;
    map["aktif"] = _aktif;
    map["link"] = _link;
    return map;
  }

}