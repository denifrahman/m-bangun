/// flag : "Toko Anugerah"
/// chilrdern : [{"id":"110","created_at":"2020-08-14 20:14:41.279496","id_produk":"29","id_user_login":"45","jumlah":"14","harga":"5000000","subtotal":"70000000","id_toko":"1","jenis_ongkir":"include_dalam_kota","catatan":"","foto":"scaled_image_picker6724287038539896222.jpg","nama":"semen gresik","nama_toko":"Toko Anugerah","id_kecamatan":"6131","foto_toko":"ramayana.png","berat":"100000","id_kota":"444","id_provinsi":"11"},{"id":"109","created_at":"2020-08-14 19:40:32.506459","id_produk":"27","id_user_login":"45","jumlah":"1","harga":"1000000","subtotal":"1000000","id_toko":"1","jenis_ongkir":"raja_ongkir","catatan":"","foto":"scaled_image_picker5911815857486830770.jpg","nama":"batako","nama_toko":"Toko Anugerah","id_kecamatan":"6131","foto_toko":"ramayana.png","berat":"100000","id_kota":"444","id_provinsi":"11"},{"id":"108","created_at":"2020-08-14 19:40:24.746809","id_produk":"28","id_user_login":"45","jumlah":"1","harga":"500000","subtotal":"500000","id_toko":"1","jenis_ongkir":"raja_ongkir","catatan":"","foto":"scaled_image_picker798869768074060374.jpg","nama":"asbes","nama_toko":"Toko Anugerah","id_kecamatan":"6131","foto_toko":"ramayana.png","berat":"10000","id_kota":"444","id_provinsi":"11"},{"id":"91","created_at":"2020-08-13 13:59:49.192174","id_produk":"31","id_user_login":"44","jumlah":"1","harga":"25000","subtotal":"25000","id_toko":"1","jenis_ongkir":"raja_ongkir","catatan":"","foto":"scaled_image_picker5306355590071312649.jpg","nama":"palu","nama_toko":"Toko Anugerah","id_kecamatan":"6131","foto_toko":"ramayana.png","berat":"5000","id_kota":"444","id_provinsi":"11"}]

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

/// id : "110"
/// created_at : "2020-08-14 20:14:41.279496"
/// id_produk : "29"
/// id_user_login : "45"
/// jumlah : "14"
/// harga : "5000000"
/// subtotal : "70000000"
/// id_toko : "1"
/// jenis_ongkir : "include_dalam_kota"
/// catatan : ""
/// foto : "scaled_image_picker6724287038539896222.jpg"
/// nama : "semen gresik"
/// nama_toko : "Toko Anugerah"
/// id_kecamatan : "6131"
/// foto_toko : "ramayana.png"
/// berat : "100000"
/// id_kota : "444"
/// id_provinsi : "11"

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
  String idKota;
  String idProvinsi;

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
    chilrdernBean.idKota = map['id_kota'];
    chilrdernBean.idProvinsi = map['id_provinsi'];
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
        "id_kota": idKota,
        "id_provinsi": idProvinsi,
      };
}