/// id_mitra : "9"
/// nama : "perbaikan kamar mandi"

class JenisLayanan {
  String idMitra;
  String nama;

  static JenisLayanan fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    JenisLayanan jenisLayananBean = JenisLayanan();
    jenisLayananBean.idMitra = map['id_mitra'];
    jenisLayananBean.nama = map['nama'];
    return jenisLayananBean;
  }

  Map toJson() => {
        "id_mitra": idMitra,
        "nama": nama,
      };
}
