/// id : "33"
/// nama : "Coba"
/// nama_layanan : "Perbaikan pagar"
/// no_order : "PROJ-1598923901"
/// deskripsi : "Sdafa"
/// budget : null
/// tipe_lokasi : "rumah"
/// latitude : null
/// longitude : null
/// alamat_lengkap : "Dafsa"
/// biaya_survey : "150000"
/// id_jenis_layanan : "1"
/// tgl_survey : null
/// status : "setuju"
/// created_at : "2020-09-02 09:01:05"
/// id_user_login : "45"
/// status_pembayaran_survey : "terbayar"
/// tgl_max_bid : "2020-09-01"
/// aktif : "1"
/// id_kecamatan : "258"
/// id_kota : "17"
/// id_provinsi : "1"
/// komisi_survey : "50000"
/// token_va : "66e80b2a-b2db-47ba-9187-c7671e93a87b"
/// batas_bayar : "2020-09-01 10:32:01.000000"
/// foto1 : null
/// foto2 : null
/// foto3 : null
/// foto4 : null

class Project {
  String id;
  String nama;
  String namaLayanan;
  String noOrder;
  String deskripsi;
  dynamic budget;
  String tipeLokasi;
  dynamic latitude;
  dynamic longitude;
  String alamatLengkap;
  String biayaSurvey;
  String idJenisLayanan;
  dynamic tglSurvey;
  String status;
  String createdAt;
  String idUserLogin;
  String statusPembayaranSurvey;
  String tglMaxBid;
  String aktif;
  String idKecamatan;
  String idKota;
  String idProvinsi;
  String komisiSurvey;
  String tokenVa;
  String batasBayar;
  dynamic foto1;
  dynamic foto2;
  dynamic foto3;
  dynamic foto4;

  static Project fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Project projectBean = Project();
    projectBean.id = map['id'];
    projectBean.nama = map['nama'];
    projectBean.namaLayanan = map['nama_layanan'];
    projectBean.noOrder = map['no_order'];
    projectBean.deskripsi = map['deskripsi'];
    projectBean.budget = map['budget'];
    projectBean.tipeLokasi = map['tipe_lokasi'];
    projectBean.latitude = map['latitude'];
    projectBean.longitude = map['longitude'];
    projectBean.alamatLengkap = map['alamat_lengkap'];
    projectBean.biayaSurvey = map['biaya_survey'];
    projectBean.idJenisLayanan = map['id_jenis_layanan'];
    projectBean.tglSurvey = map['tgl_survey'];
    projectBean.status = map['status'];
    projectBean.createdAt = map['created_at'];
    projectBean.idUserLogin = map['id_user_login'];
    projectBean.statusPembayaranSurvey = map['status_pembayaran_survey'];
    projectBean.tglMaxBid = map['tgl_max_bid'];
    projectBean.aktif = map['aktif'];
    projectBean.idKecamatan = map['id_kecamatan'];
    projectBean.idKota = map['id_kota'];
    projectBean.idProvinsi = map['id_provinsi'];
    projectBean.komisiSurvey = map['komisi_survey'];
    projectBean.tokenVa = map['token_va'];
    projectBean.batasBayar = map['batas_bayar'];
    projectBean.foto1 = map['foto1'];
    projectBean.foto2 = map['foto2'];
    projectBean.foto3 = map['foto3'];
    projectBean.foto4 = map['foto4'];
    return projectBean;
  }

  Map toJson() => {
        "id": id,
        "nama": nama,
        "nama_layanan": namaLayanan,
        "no_order": noOrder,
        "deskripsi": deskripsi,
        "budget": budget,
        "tipe_lokasi": tipeLokasi,
        "latitude": latitude,
        "longitude": longitude,
        "alamat_lengkap": alamatLengkap,
        "biaya_survey": biayaSurvey,
        "id_jenis_layanan": idJenisLayanan,
        "tgl_survey": tglSurvey,
        "status": status,
        "created_at": createdAt,
        "id_user_login": idUserLogin,
        "status_pembayaran_survey": statusPembayaranSurvey,
        "tgl_max_bid": tglMaxBid,
        "aktif": aktif,
        "id_kecamatan": idKecamatan,
        "id_kota": idKota,
        "id_provinsi": idProvinsi,
        "komisi_survey": komisiSurvey,
        "token_va": tokenVa,
        "batas_bayar": batasBayar,
        "foto1": foto1,
        "foto2": foto2,
        "foto3": foto3,
        "foto4": foto4,
      };
}
