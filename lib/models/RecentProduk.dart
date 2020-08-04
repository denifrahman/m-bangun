/// nama : "Beton"
/// id : "1"
/// slug : "beton"
/// berat : "100"
/// harga : "100"
/// kondisi : "baru"
/// foto : "beton.png"
/// jumlah_favorite : "2"
/// jumlah_dilihat : "2"
/// jumlah_dibeli : "3"
/// price1 : null
/// nama_kategori : "Bahan Bangunan"
/// icon : "bahan_bangunan.png"
/// id_kategori : "1"
/// stok : "10"
/// nama_toko : null

class RecentProduk {
  String nama;
  String id;
  String slug;
  String berat;
  String harga;
  String kondisi;
  String foto;
  String jumlahFavorite;
  String jumlahDilihat;
  String jumlahDibeli;
  dynamic price1;
  String namaKategori;
  String icon;
  String idKategori;
  String stok;
  dynamic namaToko;

  static RecentProduk fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RecentProduk recentProdukBean = RecentProduk();
    recentProdukBean.nama = map['nama'];
    recentProdukBean.id = map['id'];
    recentProdukBean.slug = map['slug'];
    recentProdukBean.berat = map['berat'];
    recentProdukBean.harga = map['harga'];
    recentProdukBean.kondisi = map['kondisi'];
    recentProdukBean.foto = map['foto'];
    recentProdukBean.jumlahFavorite = map['jumlah_favorite'];
    recentProdukBean.jumlahDilihat = map['jumlah_dilihat'];
    recentProdukBean.jumlahDibeli = map['jumlah_dibeli'];
    recentProdukBean.price1 = map['price1'];
    recentProdukBean.namaKategori = map['nama_kategori'];
    recentProdukBean.icon = map['icon'];
    recentProdukBean.idKategori = map['id_kategori'];
    recentProdukBean.stok = map['stok'];
    recentProdukBean.namaToko = map['nama_toko'];
    return recentProdukBean;
  }

  Map toJson() => {
        "nama": nama,
        "id": id,
        "slug": slug,
        "berat": berat,
        "harga": harga,
        "kondisi": kondisi,
        "foto": foto,
        "jumlah_favorite": jumlahFavorite,
        "jumlah_dilihat": jumlahDilihat,
        "jumlah_dibeli": jumlahDibeli,
        "price1": price1,
        "nama_kategori": namaKategori,
        "icon": icon,
        "id_kategori": idKategori,
        "stok": stok,
        "nama_toko": namaToko,
      };
}
