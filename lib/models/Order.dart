/// id : "25"
/// no_order : "1111125"
/// id_toko : "3"
/// id_pembeli : "35"
/// subtotal : "300"
/// total_ongkir : "27000"
/// total : "27300"
/// metode_pembayaran : "Bank Transfer"
/// status_pembayaran : "menunggu"
/// status_order : null
/// total_diskon : "0"
/// total_lain_lain : "0"
/// no_resi : null
/// kode_kurir : "tiki"
/// nama_kurir : "Citra Van Titipan Kilat (TIKI)"
/// estimasi_pengiriman : "1"
/// jenis_service : "ONS"
/// no_invoice : null
/// no_rekening : "9888888852"
/// nama_rekening : "m-bangun"
/// nama_bank : "BRI"
/// created_at : "2020-08-06 17:00:08"
/// foto : "beton.png"
/// nama_toko : "Pasir"
/// batas_bayar : "2020-08-07 17:00:08"

class Order {
  String id;
  String noOrder;
  String idToko;
  String idPembeli;
  String subtotal;
  String totalOngkir;
  String total;
  String metodePembayaran;
  String statusPembayaran;
  dynamic statusOrder;
  String totalDiskon;
  String totalLainLain;
  dynamic noResi;
  String kodeKurir;
  String namaKurir;
  String estimasiPengiriman;
  String jenisService;
  dynamic noInvoice;
  String noRekening;
  String namaRekening;
  String namaBank;
  String createdAt;
  String foto;
  String namaToko;
  String batasBayar;

  static Order fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Order orderBean = Order();
    orderBean.id = map['id'];
    orderBean.noOrder = map['no_order'];
    orderBean.idToko = map['id_toko'];
    orderBean.idPembeli = map['id_pembeli'];
    orderBean.subtotal = map['subtotal'];
    orderBean.totalOngkir = map['total_ongkir'];
    orderBean.total = map['total'];
    orderBean.metodePembayaran = map['metode_pembayaran'];
    orderBean.statusPembayaran = map['status_pembayaran'];
    orderBean.statusOrder = map['status_order'];
    orderBean.totalDiskon = map['total_diskon'];
    orderBean.totalLainLain = map['total_lain_lain'];
    orderBean.noResi = map['no_resi'];
    orderBean.kodeKurir = map['kode_kurir'];
    orderBean.namaKurir = map['nama_kurir'];
    orderBean.estimasiPengiriman = map['estimasi_pengiriman'];
    orderBean.jenisService = map['jenis_service'];
    orderBean.noInvoice = map['no_invoice'];
    orderBean.noRekening = map['no_rekening'];
    orderBean.namaRekening = map['nama_rekening'];
    orderBean.namaBank = map['nama_bank'];
    orderBean.createdAt = map['created_at'];
    orderBean.foto = map['foto'];
    orderBean.namaToko = map['nama_toko'];
    orderBean.batasBayar = map['batas_bayar'];
    return orderBean;
  }

  Map toJson() => {
        "id": id,
        "no_order": noOrder,
        "id_toko": idToko,
        "id_pembeli": idPembeli,
        "subtotal": subtotal,
        "total_ongkir": totalOngkir,
        "total": total,
        "metode_pembayaran": metodePembayaran,
        "status_pembayaran": statusPembayaran,
        "status_order": statusOrder,
        "total_diskon": totalDiskon,
        "total_lain_lain": totalLainLain,
        "no_resi": noResi,
        "kode_kurir": kodeKurir,
        "nama_kurir": namaKurir,
        "estimasi_pengiriman": estimasiPengiriman,
        "jenis_service": jenisService,
        "no_invoice": noInvoice,
        "no_rekening": noRekening,
        "nama_rekening": namaRekening,
        "nama_bank": namaBank,
        "created_at": createdAt,
        "foto": foto,
        "nama_toko": namaToko,
        "batas_bayar": batasBayar,
      };
}
