/// Sehat : "4"
/// ODP : "0"
/// PDP : "0"
/// POSITIF : "0"
/// nama_kabkota : "SURABAYA"

class CountKota {
  String Sehat;
  String ODP;
  String PDP;
  String POSITIF;
  String namaKabkota;

  static CountKota fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CountKota countKotaBean = CountKota();
    countKotaBean.Sehat = map['Sehat'];
    countKotaBean.ODP = map['ODP'];
    countKotaBean.PDP = map['PDP'];
    countKotaBean.POSITIF = map['POSITIF'];
    countKotaBean.namaKabkota = map['nama_kabkota'];
    return countKotaBean;
  }

  Map toJson() => {
        "Sehat": Sehat,
        "ODP": ODP,
        "PDP": PDP,
        "POSITIF": POSITIF,
        "nama_kabkota": namaKabkota,
      };
}
