/// id : "6"
/// nama : "themustika"
/// thumbnail : "logothemustika.jpeg"
/// tgl_mulai : null
/// tgl_selesai : null
/// urutan : null
/// aktif : "0"
/// link : "https:/themustikaland.co.id"

class IklanTokoLink {
  String id;
  String nama;
  String thumbnail;
  dynamic tglMulai;
  dynamic tglSelesai;
  dynamic urutan;
  String aktif;
  String link;

  static IklanTokoLink fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    IklanTokoLink iklanTokoLinkBean = IklanTokoLink();
    iklanTokoLinkBean.id = map['id'];
    iklanTokoLinkBean.nama = map['nama'];
    iklanTokoLinkBean.thumbnail = map['thumbnail'];
    iklanTokoLinkBean.tglMulai = map['tgl_mulai'];
    iklanTokoLinkBean.tglSelesai = map['tgl_selesai'];
    iklanTokoLinkBean.urutan = map['urutan'];
    iklanTokoLinkBean.aktif = map['aktif'];
    iklanTokoLinkBean.link = map['link'];
    return iklanTokoLinkBean;
  }

  Map toJson() => {
        "id": id,
        "nama": nama,
        "thumbnail": thumbnail,
        "tgl_mulai": tglMulai,
        "tgl_selesai": tglSelesai,
        "urutan": urutan,
        "aktif": aktif,
        "link": link,
      };
}
