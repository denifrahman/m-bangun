/// flag : "Toko Anugerah"
/// chilrdern : [{"id":"27","created_at":"2020-08-03 16:29:04.128076","id_produk":"1","id_user_login":"35","jumlah":"3","harga":"100000","subtotal":"300000","id_toko":"1","jenis_ongkir":"iclude","catatan":"","foto":"beton.png","nama":"Beton Adhimix terbaik jawa timur","nama_toko":"Toko Anugerah"},{"id":"1","created_at":"2020-08-02 13:29:34.506997","id_produk":"1","id_user_login":"1","jumlah":"2","harga":"10000","subtotal":"20000","id_toko":"1","jenis_ongkir":"1","catatan":null,"foto":"beton.png","nama":"Beton Adhimix terbaik jawa timur","nama_toko":"Toko Anugerah"}]

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

/// id : "27"
/// created_at : "2020-08-03 16:29:04.128076"
/// id_produk : "1"
/// id_user_login : "35"
/// jumlah : "3"
/// harga : "100000"
/// subtotal : "300000"
/// id_toko : "1"
/// jenis_ongkir : "iclude"
/// catatan : ""
/// foto : "beton.png"
/// nama : "Beton Adhimix terbaik jawa timur"
/// nama_toko : "Toko Anugerah"

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
    return chilrdernBean;
  }

  Map toJson() => {
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
      };
}
