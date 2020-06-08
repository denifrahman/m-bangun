import 'dart:convert';
import 'dart:io';

import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/models/KategoriM.dart';
import 'package:apps/models/SubKategoriM.dart';
import 'package:apps/provider/Api.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class WidgetUpdateAkun extends StatefulWidget {
  WidgetUpdateAkun({Key key}) : super(key: key);

  @override
  _WidgetUpdateAkunState createState() {
    return _WidgetUpdateAkunState();
  }
}

class _WidgetUpdateAkunState extends State<WidgetUpdateAkun> {
  var dataKategori = new List<KategoriM>();
  var dataSubKategori = new List<SubKategoriM>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String idKategori;
  String idSubKategori;
  String idSubKategoriSave;
  int currentStep = 0;
  File _imageFileSiup;
  File _imageFileAkte;
  String fotoUrl = '';
  String titleButtonLanjut = "Lanjut";
  String titleButtonSimpan = "Simpan";
  String titleButtonKembali = "Kembali";
  final FocusNode myFocusNodeNamaPerusahaan = FocusNode();
  TextEditingController namaPerusahaanController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _showDialog();
    _getAllByFilterParam();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool complete = false;

  next() {
    _formKey.currentState.validate();
    if (currentStep == 0) {
      currentStep + 1 != 3
          ? goTo(currentStep + 1)
          : setState(() => complete = true);
      print(currentStep);
    } else {
      currentStep + 1 != 3
          ? goTo(currentStep + 1)
          : setState(() => complete = true);
      print(currentStep);
    }
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
      setState(() => complete = true);
      setState(() {
        idSubKategori = null;
      });
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    bool step0 = false;
    bool step1 = false;
    if (currentStep == 0) {
      step0 = true;
    } else if (currentStep == 1) {
      step0 = true;
      step1 = true;
    }
    var widget1 = MediaQuery.of(context).size.height - 230;
    return Form(
      key: _formKey,
      autovalidate: false,
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Stepper(
                  steps: [
                    Step(
                        isActive: step0,
                        state: StepState.indexed,
                        title: const Text('Pilih Kategori'),
                        content: Container(
                          height: MediaQuery.of(context).size.height / 2.5,
                          child: ListView.builder(
                              itemCount: dataKategori.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () => _onchangeKategori(
                                          dataKategori[index].produkkategoriid),
                                      child: ListTile(
                                        leading: Image.network(
                                          dataKategori[index]
                                                      .produkkategorithumbnail ==
                                                  null
                                              ? 'https://previews.123rf.com/images/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-photo-not-available-vector-icon-isolated-on-transparent-background-photo-not-available-logo-concept.jpg'
                                              : dataKategori[index]
                                                  .produkkategorithumbnail,
                                          width: 45,
                                        ),
                                        title: Text(dataKategori[index]
                                            .produkkategorinama),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 12,
                                        ),
                                      ),
                                    ),
                                    Divider()
                                  ],
                                );
                              }),
                        )),
                    Step(
                      isActive: step1,
                      state: StepState.indexed,
                      title: const Text('Pilih Sub kategori'),
                      content: Container(
                        height: widget1,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  idKategori == null
                                      ? Container()
                                      : Container(
                                          height: 200,
                                          child: ListView.builder(
                                              itemCount: dataSubKategori.length,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: <Widget>[
                                                    InkWell(
                                                      onTap: () =>
                                                          _onchangeSubKategori(
                                                              dataSubKategori[
                                                                      index]
                                                                  .produkkategorisubid),
                                                      child: ListTile(
                                                        leading: Image.network(
                                                          dataSubKategori[index]
                                                                      .produkkategorisubthubmnail ==
                                                                  null
                                                              ? 'https://previews.123rf.com/images/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-photo-not-available-vector-icon-isolated-on-transparent-background-photo-not-available-logo-concept.jpg'
                                                              : dataSubKategori[
                                                                      index]
                                                                  .produkkategorisubthubmnail,
                                                          width: 45,
                                                        ),
                                                        title: Text(dataSubKategori[
                                                                index]
                                                            .produkkategorisubnama),
                                                        trailing: idSubKategori ==
                                                                dataSubKategori[
                                                                        index]
                                                                    .produkkategorisubid
                                                            ? Icon(
                                                                Icons.check_box,
                                                                color: Colors
                                                                    .green,
                                                                size: 22,
                                                              )
                                                            : null,
                                                      ),
                                                    ),
                                                    Divider()
                                                  ],
                                                );
                                              }),
                                        ),
                                  Container(
                                    height: 20,
                                  ),
                                ],
                              ),
                              idKategori == '1' || idKategori == '4'
                                  ? Column(
                                      children: <Widget>[
                                        _perusahaan(),
                                        Container(
                                          height: 20,
                                        ),
                                        _fotoSiup(),
                                        Container(
                                          height: 20,
                                        ),
                                        _fotoAkte(),
                                        Container(
                                          height: 20,
                                        ),
                                      ],
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                  currentStep: currentStep,
                  onStepContinue: next,
                  onStepTapped: (step) => goTo(step),
                  onStepCancel: cancel,
                  type: StepperType.horizontal,
                  controlsBuilder: (BuildContext context,
                          {VoidCallback onStepContinue,
                          VoidCallback onStepCancel}) =>
                      currentStep == 1 || currentStep == 2
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: 130,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.red),
                                  child: InkWell(
                                    onTap: onStepCancel,
                                    child: Center(
                                        child: Text(
                                      titleButtonKembali,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    )),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 130,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0xffb16a085)),
                                  child: InkWell(
                                    onTap: _simpanData,
                                    child: Center(
                                        child: Text(
                                      'Simpan',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    )),
                                  ),
                                ),
                              ],
                            )
                          : currentStep == 3 ? Container() : Container()),
            ),
//              new Text(
//                'Kategori Request',
//                style: TextStyle(
//                    fontSize: 12,
//                    fontWeight: FontWeight.w800,
//                    color: Colors.grey),
//              ),
//              Container(
//                width: MediaQuery.of(context).size.width - 10,
//                child: DropdownButtonFormField<String>(
//                  isDense: true,
//                  validator: (String arg) {
//                    if (arg == null)
//                      return 'Silahkan pilih terbelih dahulu';
//                    else
//                      return null;
//                  },
//                  hint: new Text(
//                    "Pilih Kategori",
//                    style: TextStyle(color: Colors.grey, fontSize: 12),
//                  ),
//                  value: idKategori,
//                  onChanged: (String newValue) {
//                    setState(() {
//                      idKategori = newValue;
//                    });
//                    _onchangeKategori(newValue);
//                  },
//                  items: dataKategori.map((KategoriM item) {
//                    return new DropdownMenuItem<String>(
//                      value: item.produkkategoriid.toString(),
//                      child: new Text(
//                        item.produkkategorinama.toString(),
//                        style: TextStyle(fontSize: 12),
//                      ),
//                    );
//                  }).toList(),
//                ),
//              ),
//              Container(
//                height: 20,
//              ),
//              idKategori == null ? Container() : _dropdownSubKategori(),
//              Container(
//                height: 20,
//              ),
//              idKategori == '1' || idKategori == '4'
//                  ? Column(
//                      children: <Widget>[
//                        _perusahaan(),
//                        Container(
//                          height: 20,
//                        ),
//                        _fotoSiup(),
//                        Container(
//                          height: 20,
//                        ),
//                        _fotoAkte()
//                      ],
//                    )
//                  : Container(),
//              Container(
//                height: 20,
//              ),
//              _buttonSimpan()
          ],
        ),
      ),
    );
  }

  Widget _perusahaan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: new TextFormField(
            focusNode: myFocusNodeNamaPerusahaan,
            controller: namaPerusahaanController,
            validator: (String arg) {
              if (arg.length < 1)
                return 'Silahkan pilih terbelih dahulu';
              else
                return null;
            },
            decoration: const InputDecoration(
                labelText: "Nama Perusahaan",
                hintText: 'PT anda',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffb16a085),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffb16a085),
                  ),
                ),
                hasFloatingPlaceholder: true),
          ),
        ),
      ],
    );
  }

  Widget _fotoSiup() {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              'Scan Surat Izin Usaha',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey),
            ),
            Container(
              height: 20,
            ),
            _imageFileSiup != null
                ? Image.file(
                    _imageFileSiup,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    width: MediaQuery.of(context).size.width,
                  )
                : Container(),
            Container(
              height: 20,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  child: Icon(Icons.camera_alt),
                  color: Colors.white,
                  padding:
                      EdgeInsets.only(left: 11, right: 11, top: 15, bottom: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  onPressed: () {
                    _openImagePickerModal(context, 'siup');
                  },
                ))
          ],
        ));
  }

  Widget _fotoAkte() {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              'Scan Akte Perusahaan',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey),
            ),
            Container(
              height: 20,
            ),
            _imageFileAkte != null
                ? Image.file(
                    _imageFileAkte,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    width: MediaQuery.of(context).size.width,
                  )
                : Container(),
            Container(
              height: 20,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  child: Icon(Icons.camera_alt),
                  color: Colors.white,
                  padding:
                      EdgeInsets.only(left: 11, right: 11, top: 15, bottom: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  onPressed: () {
                    _openImagePickerModal(context, 'akte');
                  },
                ))
          ],
        ));
  }

  Widget _dropdownSubKategori() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Sub Kategori Request',
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w800, color: Colors.grey),
        ),
        Container(
          width: MediaQuery.of(context).size.width - 10,
          child: DropdownButtonFormField<String>(
            isDense: true,
            validator: (String arg) {
              if (arg == null)
                return 'Sub kategori harus di isi';
              else
                return null;
            },
            hint: new Text(
              "Pilih Sub Kategori",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            value: idSubKategori,
            onChanged: (String newValue) {
              setState(() {
                idSubKategoriSave = newValue;
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

  void _getAllByFilterParam() async {
    String tokenValid = await LocalStorage.sharedInstance.readValue('token');
    Api.getAllByFilterParam(tokenValid, '1').then((response) {
      Iterable list = json.decode(response.body)['data'];
      setState(() {
        dataKategori = list.map((model) => KategoriM.fromMap(model)).toList();
      });
    });
  }

  void _onchangeKategori(String newValue) async {
    setState(() {
      idKategori = newValue;
    });
    String token = await LocalStorage.sharedInstance.readValue('token');
    Api.getAllSubKategoriByIdKategori(token, newValue.toString())
        .then((response) {
//      print(response.body);
      Iterable list = json.decode(response.body)['data'];
      setState(() {
        dataSubKategori =
            list.map((model) => SubKategoriM.fromMap(model)).toList();
      });
      next();
    });
  }

  void _onchangeSubKategori(String newValue) {
    setState(() {
      idSubKategori = newValue;
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
    File image = await ImagePicker.pickImage(source: source);
    if (param == 'akte') {
      setState(() {
        _imageFileAkte = image;
      });
    } else {
      setState(() {
        _imageFileSiup = image;
      });
    }
    Navigator.pop(context);
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

  void _simpanData() async {
    String dataSession = await LocalStorage.sharedInstance.readValue('session');
    var userid = json.decode(dataSession)['data']['data_user']['userid'];
    if (_formKey.currentState.validate()) {
      if (idKategori == '1' || idKategori == '4') {
        if (_imageFileSiup != null &&
            _imageFileAkte != null &&
            idSubKategori != null) {
          Api.updateAkun(_imageFileSiup, _imageFileAkte, idKategori,
                  idSubKategori, namaPerusahaanController.text, userid)
              .then((response) {
            var data = json.decode(response.body);
            print(data);
            if (data['status'] == true) {
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
//          getProfileUpdate();
            }
          });
        } else {
          Flushbar(
            title: "Gagal",
            message: 'Pastikan Sudah melampirkan gambar akte dan siup',
            duration: Duration(seconds: 15),
            backgroundColor: Colors.red,
            flushbarPosition: FlushbarPosition.TOP,
            icon: Icon(
              Icons.assignment_turned_in,
              color: Colors.white,
            ),
          )..show(context);
        }
      } else {
        Api.updateAkun(_imageFileSiup, _imageFileAkte, idKategori,
                idSubKategori, namaPerusahaanController.text, userid)
            .then((response) {
          var data = json.decode(response.body);
          print(data);
          if (data['status'] == true) {
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
          }
        });
      }
    }
  }

  Widget _buttonSimpan() {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        child: Text("Daftar"),
        color: Colors.cyan,
        textColor: Colors.white,
        padding: EdgeInsets.only(left: 11, right: 11, top: 15, bottom: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        onPressed: () {
          _simpanData();
        },
      ),
    );
  }
}
