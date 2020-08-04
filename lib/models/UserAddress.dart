/// id : "7"
/// nama_penerima : "sdadsa"
/// no_hp : "092384242"
/// id_kecamatan : "1779"
/// alamat_lengkap : "sdada"
/// default : "0"
/// id_user : "35"
/// nama_alamat : "Donald’s "

class UserAddress {
  String id;
  String namaPenerima;
  String noHp;
  String idKecamatan;
  String alamatLengkap;
  String defaultAlamat;
  String idUser;
  String namaAlamat;

  static UserAddress fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    UserAddress userAddressBean = UserAddress();
    userAddressBean.id = map['id'];
    userAddressBean.namaPenerima = map['nama_penerima'];
    userAddressBean.noHp = map['no_hp'];
    userAddressBean.idKecamatan = map['id_kecamatan'];
    userAddressBean.alamatLengkap = map['alamat_lengkap'];
    userAddressBean.defaultAlamat = map['default'];
    userAddressBean.idUser = map['id_user'];
    userAddressBean.namaAlamat = map['nama_alamat'];
    return userAddressBean;
  }

  Map toJson() => {
        "id": id,
        "nama_penerima": namaPenerima,
        "no_hp": noHp,
        "id_kecamatan": idKecamatan,
        "alamat_lengkap": alamatLengkap,
        "default": defaultAlamat,
        "id_user": idUser,
        "nama_alamat": namaAlamat,
      };
}
