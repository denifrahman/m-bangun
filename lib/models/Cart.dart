/// flag : "Pasir"
/// chilrdern : [{"id":"35","created_at":"2020-08-04 11:54:53.283426","id_produk":"5","id_user_login":"35","jumlah":"2","harga":"100","subtotal":"200","id_toko":"3","jenis_ongkir":"iclude","catatan":"warna merah muda","foto":"ramayana.png","nama":"Pasir","nama_toko":"Pasir","id_kecamatan":"6133","foto_toko":"pasir.png"}]

class Cart {
  String flag;
  List<ChilrdernBean> chilrdern;

  static Cart fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Cart cartBean = Cart();
    cartBean.flag = map['flag'];
    cartBean.chilrdern = List()..addAll((map['chilrdern'] as List ?? []).map((o) => ChilrdernBean.fromMap(o)));
    return cartBean;
  }

  Map toJson() => {
        "flag": flag,
        "chilrdern": chilrdern,
      };
}

/// id : "35"
/// created_at : "2020-08-04 11:54:53.283426"
/// id_produk : "5"
/// id_user_login : "35"
/// jumlah : "2"
/// harga : "100"
/// subtotal : "200"
/// id_toko : "3"
/// jenis_ongkir : "iclude"
/// catatan : "warna merah muda"
/// foto : "ramayana.png"
/// nama : "Pasir"
/// nama_toko : "Pasir"
/// id_kecamatan : "6133"
/// foto_toko : "pasir.png"

class ChilrdernBean {
  String id;
  String createdAt;
  String idProduk;
  String idUserLogin;
  String jumlah;
  String harga;
  String subtotal;
  String idToko;
  String jenisOngkir;
  String catatan;
  String foto;
  String nama;
  String namaToko;
  String idKecamatan;
  String fotoToko;
  String berat;

  static ChilrdernBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ChilrdernBean chilrdernBean = ChilrdernBean();
    chilrdernBean.id = map['id'];
    chilrdernBean.createdAt = map['created_at'];
    chilrdernBean.idProduk = map['id_produk'];
    chilrdernBean.idUserLogin = map['id_user_login'];
    chilrdernBean.jumlah = map['jumlah'];
    chilrdernBean.harga = map['harga'];
    chilrdernBean.subtotal = map['subtotal'];
    chilrdernBean.idToko = map['id_toko'];
    chilrdernBean.jenisOngkir = map['jenis_ongkir'];
    chilrdernBean.catatan = map['catatan'];
    chilrdernBean.foto = map['foto'];
    chilrdernBean.nama = map['nama'];
    chilrdernBean.namaToko = map['nama_toko'];
    chilrdernBean.idKecamatan = map['id_kecamatan'];
    chilrdernBean.fotoToko = map['foto_toko'];
    chilrdernBean.berat = map['berat'];
    return chilrdernBean;
  }

  Map toJson() =>
      {
        "id": id,
        "created_at": createdAt,
        "id_produk": idProduk,
        "id_user_login": idUserLogin,
        "jumlah": jumlah,
        "harga": harga,
        "subtotal": subtotal,
        "id_toko": idToko,
        "jenis_ongkir": jenisOngkir,
        "catatan": catatan,
        "foto": foto,
        "nama": nama,
        "nama_toko": namaToko,
        "id_kecamatan": idKecamatan,
        "foto_toko": fotoToko,
        "berat": berat,
      };
}