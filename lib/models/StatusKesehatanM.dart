/// id : "1"
/// status_nama : "ODP"

class StatusKesehatanM {
  String id;
  String statusNama;

  static StatusKesehatanM fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    StatusKesehatanM StatusKesehatanMBean = StatusKesehatanM();
    StatusKesehatanMBean.id = map['id'];
    StatusKesehatanMBean.statusNama = map['status_nama'];
    return StatusKesehatanMBean;
  }

  Map toJson() => {
        "id": id,
        "status_nama": statusNama,
      };
}
