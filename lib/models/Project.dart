/// id : "57"
/// nama : "Coba"
/// nama_layanan : "Pengadaan"
/// no_order : "PROJ-1600913847"
/// deskripsi : "Coba"
/// budget : "10000000"
/// tipe_lokasi : "apartemen"
/// latitude : null
/// longitude : null
/// alamat_lengkap : "Coba"
/// biaya_survey : "55000"
/// id_jenis_layanan : "2"
/// tgl_survey : "2020-09-24 09:18:34"
/// status : "proses"
/// created_at : "2020-09-24 14:39:54"
/// id_user_login : "45"
/// status_pembayaran_survey : "terbayar"
/// tgl_max_bid : "2020-09-24"
/// aktif : "1"
/// id_kecamatan : "1072"
/// id_kota : "80"
/// id_provinsi : "11"
/// komisi_survey : "30000"
/// token_va : "c9af1a86-7174-411c-9a5e-d5d6436e6198"
/// batas_bayar : "2020-09-24 11:17:49.000000"
/// foto1 : "image_picker_57FA5D7D-23E5-44D8-9850-D24C4C5415F1-59037-00008C21E3161C32.jpg"
/// foto2 : "image_picker_BCC633AA-6C88-466E-A35B-B68991F423CF-59037-00008C22E065867C.jpg"
/// foto3 : "image_picker_653EA529-05DA-4477-94AD-556012631728-59037-00008C23E695076B.jpg"
/// foto4 : null
/// no_hp : "081331339866"
/// termin1 : "50"
/// termin2 : "50"
/// termin3 : "0"
/// retensi : "0"
/// termin : "1"
/// user_ttd : "signatured_user_57_45.png"
/// mitra_ttd : null
/// mbangun_ttd : null
/// file_laporan_akhir : null

class Project {
  String id;
  String nama;
  String namaLayanan;
  String noOrder;
  String deskripsi;
  String budget;
  String tipeLokasi;
  dynamic latitude;
  dynamic longitude;
  String alamatLengkap;
  String biayaSurvey;
  String idJenisLayanan;
  String tglSurvey;
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
  String foto1;
  String foto2;
  String foto3;
  dynamic foto4;
  String noHp;
  String termin1;
  String termin2;
  String termin3;
  String retensi;
  String termin;
  String userTtd;
  dynamic mitraTtd;
  dynamic mbangunTtd;
  dynamic fileLaporanAkhir;

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
    projectBean.noHp = map['no_hp'];
    projectBean.termin1 = map['termin1'];
    projectBean.termin2 = map['termin2'];
    projectBean.termin3 = map['termin3'];
    projectBean.retensi = map['retensi'];
    projectBean.termin = map['termin'];
    projectBean.userTtd = map['user_ttd'];
    projectBean.mitraTtd = map['mitra_ttd'];
    projectBean.mbangunTtd = map['mbangun_ttd'];
    projectBean.fileLaporanAkhir = map['file_laporan_akhir'];
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
        "no_hp": noHp,
        "termin1": termin1,
        "termin2": termin2,
        "termin3": termin3,
        "retensi": retensi,
        "termin": termin,
        "user_ttd": userTtd,
        "mitra_ttd": mitraTtd,
        "mbangun_ttd": mbangunTtd,
        "file_laporan_akhir": fileLaporanAkhir,
      };
}