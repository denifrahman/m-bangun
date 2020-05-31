/// detail_kebutuhan_id : "1"
/// m_akun_id : "105606415908453146944"
/// time_insert : "2020-03-30 08:51:43"
/// kebutuhan_nama : "BERAS"

class KebutuhanM {
  String detailKebutuhanId;
  String mAkunId;
  String timeInsert;
  String kebutuhanNama;

  static KebutuhanM fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    KebutuhanM kebutuhanMBean = KebutuhanM();
    kebutuhanMBean.detailKebutuhanId = map['detail_kebutuhan_id'];
    kebutuhanMBean.mAkunId = map['m_akun_id'];
    kebutuhanMBean.timeInsert = map['time_insert'];
    kebutuhanMBean.kebutuhanNama = map['kebutuhan_nama'];
    return kebutuhanMBean;
  }

  Map toJson() => {
        "detail_kebutuhan_id": detailKebutuhanId,
        "m_akun_id": mAkunId,
        "time_insert": timeInsert,
        "kebutuhan_nama": kebutuhanNama,
      };
}
