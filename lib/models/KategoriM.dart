/// produkkategoriid : "1"
/// produkkategorinama : "Kontraktor"
/// produkkategoriaktif : "1"
/// produkkategorithumbnail : "http://arsitekinterior.com/wp-content/uploads/icon-jasa-kontraktor.png"

class KategoriM {
  String produkkategoriid;
  String produkkategorinama;
  String produkkategoriaktif;
  String produkkategorithumbnail;

  static KategoriM fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    KategoriM kategoriMBean = KategoriM();
    kategoriMBean.produkkategoriid = map['produkkategoriid'];
    kategoriMBean.produkkategorinama = map['produkkategorinama'];
    kategoriMBean.produkkategoriaktif = map['produkkategoriaktif'];
    kategoriMBean.produkkategorithumbnail = map['produkkategorithumbnail'];
    return kategoriMBean;
  }

  Map toJson() => {
    "produkkategoriid": produkkategoriid,
    "produkkategorinama": produkkategorinama,
    "produkkategoriaktif": produkkategoriaktif,
    "produkkategorithumbnail": produkkategorithumbnail,
  };
}