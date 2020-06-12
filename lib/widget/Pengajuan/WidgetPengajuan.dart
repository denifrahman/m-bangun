import 'dart:convert';
import 'dart:io';
import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/models/KecamatanM.dart';
import 'package:apps/models/KotaM.dart';
import 'package:apps/models/ProvinsiM.dart';
import 'package:apps/models/SubKategoriM.dart';
import 'package:apps/models/jenis_pengajuan.dart';
import 'package:apps/provider/Api.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class WidgetPengajuan extends StatefulWidget {
  WidgetPengajuan({Key key}) : super(key: key);

  @override
  _WidgetPengajuanState createState() {
    return _WidgetPengajuanState();
  }
}

class _WidgetPengajuanState extends State<WidgetPengajuan> {
  var dataJenisPengajuan = new List<JenisPengajuan>();
  var dataSubKategori = new List<SubKategoriM>();
  String idSubKategori;
  bool _saving = false;
  String idKota;
  String idProvinsi;
  String idKecamatan;
  String namaProvinsi, namaKota, namaKecamatan;
  var dataKota = List<KotaM>();
  var dataProvinsi = List<ProvinsiM>();
  var dataKecamatan = List<KecamatanM>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String jenispengajuanid;

  final FocusNode myFocusNodeUniversitas = FocusNode();
  TextEditingController universitasController = new TextEditingController();

  final FocusNode myFocusNodeFakultas = FocusNode();
  TextEditingController fakultasController = new TextEditingController();

  final FocusNode myFocusNodeJurusan = FocusNode();
  TextEditingController jurusanController = new TextEditingController();

  final FocusNode myFocusNodePanjang = FocusNode();
  TextEditingController panjangController = new TextEditingController();

  final FocusNode myFocusNodeLebar = FocusNode();
  TextEditingController lebarController = new TextEditingController();

  final FocusNode myFocusNodeTinggi = FocusNode();
  TextEditingController tinggiController = new TextEditingController();

  final FocusNode myFocusNodeAlamat = FocusNode();
  TextEditingController alamatController = new TextEditingController();

  final FocusNode myFocusNodeBahan = FocusNode();
  TextEditingController bahanController = new TextEditingController();

  final FocusNode myFocusNodeJenisPekerjaan = FocusNode();
  TextEditingController jenisPekerjaanController = new TextEditingController();

  final FocusNode myFocusNodeBudget = FocusNode();
  TextEditingController budgetController = new TextEditingController();

  final FocusNode myFocusNodeNama = FocusNode();
  TextEditingController namaController = new TextEditingController();

  final FocusNode myFocusNodeAlamatLengkap = FocusNode();
  TextEditingController alamatLengkapController = new TextEditingController();

  @override
  File produkthumbnail;
  File produkfoto1;
  File produkfoto2;
  File produkfoto3;
  File produkfoto4;

  void initState() {
    super.initState();
    getAllJenisPengajuan();
    getAllSubKategori();
    getAllProvinsi();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getAllProvinsi() async {
    String tokenValid = await LocalStorage.sharedInstance.readValue('token');
    Api.getAllProvinsi(tokenValid).then((value) {
      var result = json.decode(value.body);
      print(result);
      Iterable list = result['data'];
      setState(() {
        dataProvinsi = list.map((model) => ProvinsiM.fromMap(model)).toList();
      });
    });
  }

  void getAllJenisPengajuan() async {
    String tokenValid = await LocalStorage.sharedInstance.readValue('token');
    Api.getAllJenisPengajuan(tokenValid).then((response) {
      Iterable list = json.decode(response.body)['data'];
      setState(() {
        dataJenisPengajuan =
            list.map((model) => JenisPengajuan.fromJson(model)).toList();
      });
    });
  }

  void getAllSubKategori() async {
    String tokenValid = await LocalStorage.sharedInstance.readValue('token');
    Api.getAllSubKategoriByIdKategori(tokenValid, '1').then((response) {
      Iterable list = json.decode(response.body)['data'];
      setState(() {
        dataSubKategori =
            list.map((model) => SubKategoriM.fromMap(model)).toList();
      });
    });
  }

  void _openImagePickerModal(BuildContext context, param) {
    final flatButtonColor = Theme.of(context).primaryColor;
    print('Image Picker Modal Called');
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Pick an image',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  textColor: Colors.red,
                  child: Text('Use Camera'),
                  onPressed: () {
                    _getImage(context, ImageSource.camera, param);
                  },
                ),
                FlatButton(
                  textColor: Colors.red,
                  child: Text('Use Gallery'),
                  onPressed: () {
                    _getImage(context, ImageSource.gallery, param);
                  },
                ),
              ],
            ),
          );
        });
  }

  void _showDialog() async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Agreement",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
          content: Container(
            child: Text(
              'Update akun anda sebagai member resmi, silahkan isi sesuai kategori usaha anda, klik setuju jika ingin melanjutkan',
              style: TextStyle(fontSize: 12),
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Tidak"),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
            new FlatButton(
              child: new Text("Setuju"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _getImage(BuildContext context, ImageSource source, param) async {
    File image = await ImagePicker.pickImage(
        source: source, maxHeight: 1000, maxWidth: 1000);
    if (param == 'produkthumbnail') {
      setState(() {
        produkthumbnail = image;
      });
    } else if (param == 'produkfoto1') {
      setState(() {
        produkfoto1 = image;
      });
    } else if (param == 'produkfoto2') {
      setState(() {
        produkfoto2 = image;
      });
    } else if (param == 'produkfoto3') {
      setState(() {
        produkfoto3 = image;
      });
    } else if (param == 'produkfoto4') {
      setState(() {
        produkfoto4 = image;
      });
    }
    Navigator.pop(context);
  }

  void _onchangeKategori(String newValue) async {
    String token = await LocalStorage.sharedInstance.readValue('token');
  }

  void _onchangeSubKategori(String newValue) {}

  void simpanFormRqt() async {
    setState(() {
      _saving = true;
    });
    String dataSession = await LocalStorage.sharedInstance.readValue('session');
    var userId = json.decode(dataSession)['data']['data_user']['userid'];
    if (_formKey.currentState.validate()) {
      var budget = budgetController.text.replaceAll('Rp', '');
      var saveBudget = budget.replaceAll(',', '');
      Api.pengajuanRqt(
              produkthumbnail,
              produkfoto1,
              produkfoto2,
              produkfoto3,
              produkfoto4,
              idSubKategori,
              idProvinsi,
              idKota,
              idKecamatan,
              alamatLengkapController.text,
              namaController.text,
              panjangController.text,
              lebarController.text,
              tinggiController.text,
              bahanController.text,
              saveBudget,
              userId)
          .then((value) {
        var data = json.decode(value.body);
        if (data['status']) {
          setState(() {
            _saving = false;
          });
          Navigator.pop(context);
          Flushbar(
            title: "Sukses",
            message: data['message'],
            duration: Duration(seconds: 15),
            backgroundColor: Colors.green,
            flushbarPosition: FlushbarPosition.TOP,
            icon: Icon(
              Icons.assignment_turned_in,
              color: Colors.white,
            ),
          )..show(context);
        } else {}
      });
    } else {
      setState(() {
        _saving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      key: _formKey,
      autovalidate: false,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: _saving
              ? Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Center(
                      child: LoadingDoubleFlipping.square(
                          size: 30, backgroundColor: Colors.red)),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _dropdownJenisPengajuan(),
                    Container(
                      height: 20,
                    ),
                    jenispengajuanid == '1'
                        ? Column(
                            children: [
                              _buildAlamat(),
                              Container(
                                height: 20,
                              ),
                              _buildFormRqt(),
                            ],
                          )
                        : jenispengajuanid == '2'
                            ? _buildFormPelatihanKerja()
                            : Container()
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildFormPelatihanKerja() {
    return Column(
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new TextFormField(
              focusNode: myFocusNodeUniversitas,
              controller: universitasController,
              validator: (String arg) {
                if (arg.length < 1)
                  return 'Harus di isi';
                else
                  return null;
              },
              decoration: const InputDecoration(
                  labelText: "Universitas",
                  hintText: 'Universitas',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffb16a085),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffb16a085),
                    ),
                  ),
                  hasFloatingPlaceholder: true),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new TextFormField(
              focusNode: myFocusNodeFakultas,
              controller: fakultasController,
              validator: (String arg) {
                if (arg.length < 1)
                  return 'Harus di isi';
                else
                  return null;
              },
              decoration: const InputDecoration(
                  labelText: "Fakultas",
                  hintText: 'Fakultas',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffb16a085),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffb16a085),
                    ),
                  ),
                  hasFloatingPlaceholder: true),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new TextFormField(
              focusNode: myFocusNodeJurusan,
              controller: jurusanController,
              validator: (String arg) {
                if (arg.length < 1)
                  return 'Harus di isi';
                else
                  return null;
              },
              decoration: const InputDecoration(
                  labelText: "Jurusan",
                  hintText: 'Jurusan',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffb16a085),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffb16a085),
                    ),
                  ),
                  hasFloatingPlaceholder: true),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new TextFormField(
              focusNode: myFocusNodeAlamat,
              controller: alamatController,
              validator: (String arg) {
                if (arg.length < 1)
                  return 'Harus di isi';
                else
                  return null;
              },
              decoration: const InputDecoration(
                  labelText: "Alamat",
                  hintText: 'Alamat',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffb16a085),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffb16a085),
                    ),
                  ),
                  hasFloatingPlaceholder: true),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormRqt() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Nama Pengajuan'),
        Container(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: new TextFormField(
            focusNode: myFocusNodeNama,
            controller: namaController,
            validator: (String arg) {
              if (arg.length < 1)
                return 'Harus di isi';
              else
                return null;
            },
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                labelText: "Nama Pengajuan",
                hintText: 'Pengajuan perbaikan rumah',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffb16a085),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffb16a085),
                  ),
                ),
                hasFloatingPlaceholder: true),
          ),
        ),
        Container(
          height: 10,
        ),
        Text('Dimensi (cm)'),
        Container(
          height: 10,
        ),
        Row(
          children: <Widget>[
            Expanded(
              // width: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  focusNode: myFocusNodePanjang,
                  controller: panjangController,
                  validator: (String arg) {
                    if (arg.length < 1)
                      return 'Harus di isi';
                    else
                      return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: "Panjang",
                      hintText: '50',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffb16a085),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffb16a085),
                        ),
                      ),
                      hasFloatingPlaceholder: true),
                ),
              ),
            ),
            Expanded(
              // width: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  focusNode: myFocusNodeLebar,
                  controller: lebarController,
                  validator: (String arg) {
                    if (arg.length < 1)
                      return 'Harus di isi';
                    else
                      return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: "Lebar",
                      hintText: '20',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffb16a085),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffb16a085),
                        ),
                      ),
                      hasFloatingPlaceholder: true),
                ),
              ),
            ),
            Expanded(
              // width: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  focusNode: myFocusNodeTinggi,
                  controller: tinggiController,
                  validator: (String arg) {
                    if (arg.length < 1)
                      return 'Harus di isi';
                    else
                      return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: "Tinggi",
                      hintText: '60',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffb16a085),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffb16a085),
                        ),
                      ),
                      hasFloatingPlaceholder: true),
                ),
              ),
            ),
          ],
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new TextFormField(
              focusNode: myFocusNodeBahan,
              controller: bahanController,
              validator: (String arg) {
                if (arg.length < 1)
                  return 'Harus di isi';
                else
                  return null;
              },
              decoration: const InputDecoration(
                  labelText: "Bahan",
                  hintText: 'Kayu, Besi, dll',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffb16a085),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffb16a085),
                    ),
                  ),
                  hasFloatingPlaceholder: true),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _dropdownSubKategori(),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new TextFormField(
              inputFormatters: [
                MoneyInputFormatter(
                    useSymbolPadding: true,
                    mantissaLength: 0,
                    leadingSymbol: 'Rp')
              ],
              focusNode: myFocusNodeBudget,
              controller: budgetController,
              validator: (String arg) {
                if (arg.length < 1)
                  return 'Harus di isi';
                else
                  return null;
              },
              textAlign: TextAlign.right,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: "Budget",
                  hintText: 'Rp 100,000',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffb16a085),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffb16a085),
                    ),
                  ),
                  hasFloatingPlaceholder: true),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      'Foto Depan',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey),
                    ),
                    Container(
                      height: 20,
                    ),
                    produkthumbnail != null
                        ? Image.file(
                            produkthumbnail,
                            fit: BoxFit.fitHeight,
                            alignment: Alignment.topCenter,
                            width: 80,
                            height: 80,
                          )
                        : Container(),
                    Container(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: IconButton(
                        highlightColor: Colors.green,
                        icon: Icon(Icons.camera_alt),
                        onPressed: () {
                          _openImagePickerModal(context, 'produkthumbnail');
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      'Foto Kanan',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey),
                    ),
                    Container(
                      height: 20,
                    ),
                    produkfoto1 != null
                        ? Image.file(
                            produkfoto1,
                            fit: BoxFit.fitHeight,
                            alignment: Alignment.topCenter,
                            width: 80,
                            height: 80,
                          )
                        : Container(),
                    Container(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () {
                          _openImagePickerModal(context, 'produkfoto1');
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      'Foto Kiri',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey),
                    ),
                    Container(
                      height: 20,
                    ),
                    produkfoto2 != null
                        ? Image.file(
                            produkfoto2,
                            fit: BoxFit.fitHeight,
                            alignment: Alignment.topCenter,
                            width: 80,
                            height: 80,
                          )
                        : Container(),
                    Container(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () {
                          _openImagePickerModal(context, 'produkfoto2');
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      'Foto Belakang',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey),
                    ),
                    Container(
                      height: 20,
                    ),
                    produkfoto3 != null
                        ? Image.file(
                            produkfoto3,
                            fit: BoxFit.fitHeight,
                            alignment: Alignment.topCenter,
                            width: 80,
                            height: 80,
                          )
                        : Container(),
                    Container(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: IconButton(
                        highlightColor: Colors.green,
                        icon: Icon(Icons.camera_alt),
                        onPressed: () {
                          _openImagePickerModal(context, 'produkfoto3');
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      'Foto Bebas',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey),
                    ),
                    Container(
                      height: 20,
                    ),
                    produkfoto4 != null
                        ? Image.file(
                            produkfoto4,
                            fit: BoxFit.fitHeight,
                            alignment: Alignment.topCenter,
                            width: 80,
                            height: 80,
                          )
                        : Container(),
                    Container(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () {
                          _openImagePickerModal(context, 'produkfoto4');
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 20,
        ),
        SizedBox(
          width: double.infinity,
          child: RaisedButton(
            child: Text("Pengajuan"),
            color: Color(0xffb16a085),
            textColor: Colors.white,
            padding: EdgeInsets.only(left: 11, right: 11, top: 15, bottom: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            onPressed: () {
              simpanFormRqt();
            },
          ),
        )
      ],
    );
  }

  Widget _dropdownSubKategori() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Jenis pekerjaan',
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
        Container(
          width: MediaQuery.of(context).size.width - 10,
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffb16a085),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffb16a085),
                ),
              ),
            ),
            isDense: true,
            validator: (String arg) {
              if (arg == null)
                return 'jenis pekerjaan harus di isi';
              else
                return null;
            },
            hint: new Text(
              "Jenis pekerjaan",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            value: idSubKategori,
            onChanged: (String newValue) {
              setState(() {
                idSubKategori = newValue;
              });
            },
            items: dataSubKategori.map((SubKategoriM item) {
              return DropdownMenuItem<String>(
                value: item.produkkategorisubid.toString(),
                child: new Text(
                  item.produkkategorisubnama.toString(),
                  style: TextStyle(fontSize: 12),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _dropdownJenisPengajuan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width - 10,
          child: DropdownButtonFormField<String>(
            isDense: true,
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffb16a085),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffb16a085),
                ),
              ),
            ),
            validator: (String arg) {
              if (arg == null)
                return 'Silahkan pilih terbelih dahulu';
              else
                return null;
            },
            hint: new Text(
              "Jenis Pengajuan",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            value: jenispengajuanid,
            onChanged: (String newValue) {
              setState(() {
                jenispengajuanid = newValue;
              });
              _onchangeKategori(newValue);
            },
            items: dataJenisPengajuan.map((JenisPengajuan item) {
              return new DropdownMenuItem<String>(
                value: item.jenispengajuanid.toString(),
                child: new Text(
                  item.jenispengajuannama.toString(),
                  style: TextStyle(fontSize: 12),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  Widget _buildAlamat() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 10,
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffb16a085),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffb16a085),
                  ),
                ),
              ),
              validator: (String arg) {
                if (arg == null)
                  return 'Provinsi harus di isi';
                else
                  return null;
              },
              isDense: true,
              hint: new Text(
                "Pilih Provinsi",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              value: idProvinsi,
              onChanged: (String newValue) {
                setState(() {
                  idProvinsi = newValue;
                  dataKota = [];
                  idKota = null;
                });
                _onchangeProvinsi(newValue);
              },
              items: dataProvinsi.map((ProvinsiM item) {
                return new DropdownMenuItem<String>(
                  value: item.idPropinsi.toString(),
                  child: new Text(
                    item.namaPropinsi.toString(),
                    style: TextStyle(fontSize: 12),
                  ),
                );
              }).toList(),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 10,
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffb16a085),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffb16a085),
                  ),
                ),
              ),
              validator: (String arg) {
                if (arg == null)
                  return 'Kota harus di isi';
                else
                  return null;
              },
              isDense: true,
              hint: new Text(
                "Pilih Kota",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              value: idKota,
              onChanged: (String newValue) {
                setState(() {
                  idKota = newValue;
                  dataKecamatan = [];
                  idKecamatan = null;
                });
                _onchangeKota(newValue);
              },
              items: dataKota.map((KotaM item) {
                return new DropdownMenuItem<String>(
                  value: item.idKabkota.toString(),
                  child: new Text(
                    item.namaKabkota.toString(),
                    style: TextStyle(fontSize: 12),
                  ),
                );
              }).toList(),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 10,
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffb16a085),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffb16a085),
                  ),
                ),
              ),
              validator: (String arg) {
                if (arg == null)
                  return 'kecamatan harus di isi';
                else
                  return null;
              },
              isDense: true,
              hint: new Text(
                "Pilih Kecamatan",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              value: idKecamatan,
              onChanged: (String newValue) {
                setState(() {
                  idKecamatan = newValue;
                });
              },
              items: dataKecamatan.map((KecamatanM item) {
                return new DropdownMenuItem<String>(
                  value: item.idKecamatan.toString(),
                  child: new Text(
                    item.namaKecamatan.toString(),
                    style: TextStyle(fontSize: 12),
                  ),
                );
              }).toList(),
            ),
          ),
          Container(
            height: 10,
          ),
          new TextFormField(
            focusNode: myFocusNodeAlamatLengkap,
            controller: alamatLengkapController,
            validator: (String arg) {
              if (arg.length < 1)
                return 'Harus di isi';
              else
                return null;
            },
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            decoration: const InputDecoration(
                labelText: "Alamat lengkap",
                hintText: 'Jl. Ir Soekarno no 1 A',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffb16a085),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffb16a085),
                  ),
                ),
                hasFloatingPlaceholder: true),
          ),
        ],
      ),
    );
  }

  void _onchangeProvinsi(String newValue) async {
    String token = await LocalStorage.sharedInstance.readValue('token');
    Api.getAllKotaByIdProvinsi(token, idProvinsi).then((value) {
      var result = json.decode(value.body);
      Iterable list = result['data'];
      setState(() {
        dataKota = list.map((model) => KotaM.fromMap(model)).toList();
      });
    });
  }

  void _onchangeKota(String newValue) async {
    String token = await LocalStorage.sharedInstance.readValue('token');
    Api.getAllKecamatanByIdKota(token, idKota).then((value) {
      var result = json.decode(value.body);
      Iterable list = result['data'];
      setState(() {
        dataKecamatan = list.map((model) => KecamatanM.fromMap(model)).toList();
      });
    });
  }
}