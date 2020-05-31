class Penjamin {
  String penjaminId;
  String mGroupPenjaminId;
  String penjaminKode;
  String penjaminNama;
  String penjaminAlamat;
  String penjaminTelp;
  String mKotaId;
  String penjaminAdmriPersen;
  String penjaminAdmriRupiah;
  String penjaminAktif;
  String penjaminCreatedBy;
  String penjaminCreatedDate;
  String penjaminUpdatedBy;
  String penjaminUpdatedDate;
  String penjaminRevised;
  String regCompanyId;
  String regAppsId;
  String mJenistarifId;

  Penjamin(
      {this.penjaminId,
      this.mGroupPenjaminId,
      this.penjaminKode,
      this.penjaminNama,
      this.penjaminAlamat,
      this.penjaminTelp,
      this.mKotaId,
      this.penjaminAdmriPersen,
      this.penjaminAdmriRupiah,
      this.penjaminAktif,
      this.penjaminCreatedBy,
      this.penjaminCreatedDate,
      this.penjaminUpdatedBy,
      this.penjaminUpdatedDate,
      this.penjaminRevised,
      this.regCompanyId,
      this.regAppsId,
      this.mJenistarifId});

  Penjamin.fromJson(Map<String, dynamic> json) {
    penjaminId = json['penjamin_id'];
    mGroupPenjaminId = json['m_group_penjamin_id'];
    penjaminKode = json['penjamin_kode'];
    penjaminNama = json['penjamin_nama'];
    penjaminAlamat = json['penjamin_alamat'];
    penjaminTelp = json['penjamin_telp'];
    mKotaId = json['m_kota_id'];
    penjaminAdmriPersen = json['penjamin_admri_persen'];
    penjaminAdmriRupiah = json['penjamin_admri_rupiah'];
    penjaminAktif = json['penjamin_aktif'];
    penjaminCreatedBy = json['penjamin_created_by'];
    penjaminCreatedDate = json['penjamin_created_date'];
    penjaminUpdatedBy = json['penjamin_updated_by'];
    penjaminUpdatedDate = json['penjamin_updated_date'];
    penjaminRevised = json['penjamin_revised'];
    regCompanyId = json['reg_company_id'];
    regAppsId = json['reg_apps_id'];
    mJenistarifId = json['m_jenistarif_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['penjamin_id'] = this.penjaminId;
    data['m_group_penjamin_id'] = this.mGroupPenjaminId;
    data['penjamin_kode'] = this.penjaminKode;
    data['penjamin_nama'] = this.penjaminNama;
    data['penjamin_alamat'] = this.penjaminAlamat;
    data['penjamin_telp'] = this.penjaminTelp;
    data['m_kota_id'] = this.mKotaId;
    data['penjamin_admri_persen'] = this.penjaminAdmriPersen;
    data['penjamin_admri_rupiah'] = this.penjaminAdmriRupiah;
    data['penjamin_aktif'] = this.penjaminAktif;
    data['penjamin_created_by'] = this.penjaminCreatedBy;
    data['penjamin_created_date'] = this.penjaminCreatedDate;
    data['penjamin_updated_by'] = this.penjaminUpdatedBy;
    data['penjamin_updated_date'] = this.penjaminUpdatedDate;
    data['penjamin_revised'] = this.penjaminRevised;
    data['reg_company_id'] = this.regCompanyId;
    data['reg_apps_id'] = this.regAppsId;
    data['m_jenistarif_id'] = this.mJenistarifId;
    return data;
  }
}
