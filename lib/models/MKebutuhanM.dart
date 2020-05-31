/// kebutuhan_id : "2"
/// kebutuhan_nama : "ALKES"

class MKebutuhanM {
  String kebutuhanId;
  String kebutuhanNama;

  static MKebutuhanM fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MKebutuhanM mKebutuhanMBean = MKebutuhanM();
    mKebutuhanMBean.kebutuhanId = map['kebutuhan_id'];
    mKebutuhanMBean.kebutuhanNama = map['kebutuhan_nama'];
    return mKebutuhanMBean;
  }

  Map toJson() => {
        "kebutuhan_id": kebutuhanId,
        "kebutuhan_nama": kebutuhanNama,
      };
}
