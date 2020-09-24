/// nama : "1nanansj"
/// email : "dellaemiliaaa@gmail.com"
/// no_hp : "1102020"
/// id_kecamatan : "2131"
/// alamat : "Bsnsnsnsn"
/// jenis_kelamin : "p"
/// no_ktp : "123444"
/// nama_pemilik : "Nsnsnsnns"
/// alamat_pemilik : "Nsnenen"
/// no_npwp : "2222"
/// id_google : "117642418095946673318"
/// status_user : "user"
/// aktif : "1"
/// foto : "https://lh5.googleusercontent.com/-uJy-SfPCThM/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuclF8VCpJmSXBRIRzdlDb2cmsXM5Ig/s96-c/photo.jpg"
/// id_mitra : "7"
/// username : "dellaemiliaaa@gmail.com"
/// id : "56"
/// aktif_mitra : "1"
/// jenis_layanan : null
/// jenis_mitra : "pt"

class Mitra {
  String nama;
  String email;
  String noHp;
  String idKecamatan;
  String alamat;
  String jenisKelamin;
  String noKtp;
  String namaPemilik;
  String alamatPemilik;
  String noNpwp;
  String idGoogle;
  String statusUser;
  String aktif;
  String foto;
  String idMitra;
  String username;
  String id;
  String aktifMitra;
  dynamic jenisLayanan;
  String jenisMitra;

  static Mitra fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Mitra mitraBean = Mitra();
    mitraBean.nama = map['nama'];
    mitraBean.email = map['email'];
    mitraBean.noHp = map['no_hp'];
    mitraBean.idKecamatan = map['id_kecamatan'];
    mitraBean.alamat = map['alamat'];
    mitraBean.jenisKelamin = map['jenis_kelamin'];
    mitraBean.noKtp = map['no_ktp'];
    mitraBean.namaPemilik = map['nama_pemilik'];
    mitraBean.alamatPemilik = map['alamat_pemilik'];
    mitraBean.noNpwp = map['no_npwp'];
    mitraBean.idGoogle = map['id_google'];
    mitraBean.statusUser = map['status_user'];
    mitraBean.aktif = map['aktif'];
    mitraBean.foto = map['foto'];
    mitraBean.idMitra = map['id_mitra'];
    mitraBean.username = map['username'];
    mitraBean.id = map['id'];
    mitraBean.aktifMitra = map['aktif_mitra'];
    mitraBean.jenisLayanan = map['jenis_layanan'];
    mitraBean.jenisMitra = map['jenis_mitra'];
    return mitraBean;
  }

  Map toJson() => {
        "nama": nama,
        "email": email,
        "no_hp": noHp,
        "id_kecamatan": idKecamatan,
        "alamat": alamat,
        "jenis_kelamin": jenisKelamin,
        "no_ktp": noKtp,
        "nama_pemilik": namaPemilik,
        "alamat_pemilik": alamatPemilik,
        "no_npwp": noNpwp,
        "id_google": idGoogle,
        "status_user": statusUser,
        "aktif": aktif,
        "foto": foto,
        "id_mitra": idMitra,
        "username": username,
        "id": id,
        "aktif_mitra": aktifMitra,
        "jenis_layanan": jenisLayanan,
        "jenis_mitra": jenisMitra,
      };
}
