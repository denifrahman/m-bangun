import 'dart:io';

import 'package:apps/Utils/SnacbarLauncher.dart';
import 'package:apps/models/Categories.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class WidgetAddProduk extends StatefulWidget {
  WidgetAddProduk({Key key}) : super(key: key);

  @override
  _WidgetAddProdukState createState() => _WidgetAddProdukState();
}

class _WidgetAddProdukState extends State<WidgetAddProduk> {
  String nama, berat, harga, minimal_pesanan, stok, panjang, deskripsi;
  String id_kategori = null;
  String kondisi = null;
  String jenis_ongkir = null;
  File foto;
  File foto1;
  File foto2;
  bool success = false;
  bool error = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      id_kategori = null;
      success = false;
      error = false;
      kondisi = null;
      jenis_ongkir = null;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    // TODO: implement build
    AppBar appBar = AppBar(
      title: Text('Tambah Produk'),
    );
    return ModalProgressHUD(
      inAsyncCall: blocProduk.isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  success
                      ? SnackBarLauncher(
                          error: 'Berhasil ditambahkan',
                          color: Colors.green,
                        )
                      : Container(),
                  error
                      ? SnackBarLauncher(
                          error: 'Periksa jaringan anda',
                          color: Colors.red,
                        )
                      : Container(),
                  Container(
                    height: 90,
                    child: TextFormField(
                      onSaved: (value) {
                        setState(() {
                          nama = value;
                        });
                      },
                      keyboardType: TextInputType.text,
                      validator: (String arg) {
                        if (arg.length < 1)
                          return 'Nama Produk Harus di isi';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Nama Produk',
                        labelText: 'Nama Produk',
                        labelStyle: TextStyle(fontSize: 16),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ),
                  Container(
                    height: 90,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: TextFormField(
                            onSaved: (value) {
                              setState(() {
                                berat = value;
                              });
                            },
                            keyboardType: TextInputType.number,
                            validator: (String arg) {
                              if (arg.length < 1)
                                return 'Berat Produk Harus di isi';
                              else
                                return null;
                            },
                            decoration: InputDecoration(
                              suffixText: 'gram',
                              hintText: 'Berat',
                              labelText: 'Berat',
                              labelStyle: TextStyle(fontSize: 16),
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ),
                        ),
                        Container(
                          height: 90,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.6,
                          child: TextFormField(
                            onSaved: (value) {
                              setState(() {
                                harga = value;
                              });
                            },
                            keyboardType: TextInputType.number,
                            validator: (String arg) {
                              if (arg.length < 1)
                                return 'Harga Produk Harus di isi';
                              else
                                return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Harga Produk',
                              labelText: 'Harga Produk',
                              prefixText: 'Rp ',
                              labelStyle: TextStyle(fontSize: 16),
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 90,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 100,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.6,
                          child: TextFormField(
                            onSaved: (value) {
                              setState(() {
                                panjang = value;
                              });
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              suffixText: 'cm',
                              hintText: 'Panjang',
                              labelText: 'Panjang',
                              labelStyle: TextStyle(fontSize: 16),
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ),
                        ),
                        Container(
                          height: 90,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.3,
                          child: TextFormField(
                            onSaved: (value) {
                              setState(() {
                                stok = value;
                              });
                            },
                            keyboardType: TextInputType.number,
                            validator: (String arg) {
                              if (arg.length < 1)
                                return 'Stok Produk Harus di isi';
                              else
                                return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Stok',
                              labelText: 'Stok',
                              labelStyle: TextStyle(fontSize: 16),
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 90,
                    child: TextFormField(
                      onSaved: (value) {
                        setState(() {
                          minimal_pesanan = value;
                        });
                      },
                      keyboardType: TextInputType.number,
                      validator: (String arg) {
                        if (arg.length < 1)
                          return 'Minimal pemesanan Produk Harus di isi';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Minimal pemesanan',
                        labelText: 'Minimal pemesanan',
                        labelStyle: TextStyle(fontSize: 16),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 10,
                    child: DropdownButtonFormField<String>(
                      isDense: true,
                      hint: new Text(
                        "Pilih Kategori",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      value: id_kategori,
                      validator: (String arg) {
                        if (arg == null)
                          return 'Harus di isi';
                        else
                          return null;
                      },
                      onChanged: (String value) {
                        setState(() {
                          id_kategori = value;
                        });
                      },
                      items: blocProduk.listCategory.isEmpty
                          ? null
                          : blocProduk.listCategory.map((Categories item) {
                              return new DropdownMenuItem<String>(
                                value: item.id,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/kategori/' + item.icon,
                                      height: 30,
                                      width: 30,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    new Text(
                                      item.nama.toString(),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 10,
                    child: DropdownButtonFormField<String>(
                        isDense: true,
                        hint: new Text(
                          "Pilih Kondisi",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        value: kondisi,
                        validator: (String arg) {
                          if (arg == null)
                            return 'Harus di isi';
                          else
                            return null;
                        },
                        onChanged: (String value) {
                          setState(() {
                            kondisi = value;
                          });
                        },
                        items: [
                          {'label': 'baru'},
                          {'label': 'bekas'}
                        ].map((e) {
                          return DropdownMenuItem<String>(
                            value: e['label'],
                            child: new Text(
                              e['label'].toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          );
                        }).toList()),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 10,
                    child: DropdownButtonFormField<String>(
                        isDense: true,
                        hint: new Text(
                          "Pilih Pengiriman",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        value: jenis_ongkir,
                        validator: (String arg) {
                          if (arg == null)
                            return 'Harus di isi';
                          else
                            return null;
                        },
                        onChanged: (String value) {
                          setState(() {
                            jenis_ongkir = value;
                          });
                        },
                        items: [
                          {'label': 'expedisi', 'value': 'raja_ongkir'},
                          {'label': 'free ongkir', 'value': 'include'}
                        ].map((e) {
                          return DropdownMenuItem<String>(
                            value: e['value'],
                            child: new Text(
                              e['label'].toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          );
                        }).toList()),
                  ),
                  SizedBox(
                    height: 5,
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
                                'Foto',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.grey),
                              ),
                              Container(
                                height: 20,
                              ),
                              foto != null
                                  ? Image.file(
                                      foto,
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
                                    _openImagePickerModal(context, 'foto');
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
                                'Foto 2',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.grey),
                              ),
                              Container(
                                height: 20,
                              ),
                              foto1 != null
                                  ? Image.file(
                                      foto1,
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
                                    _openImagePickerModal(context, 'foto1');
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
                                'Foto 2',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.grey),
                              ),
                              Container(
                                height: 20,
                              ),
                              foto2 != null
                                  ? Image.file(
                                      foto2,
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
                                    _openImagePickerModal(context, 'foto2');
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
                  Container(
                    height: 90,
                    child: TextFormField(
                      maxLines: 10,
                      onSaved: (value) {
                        setState(() {
                          deskripsi = value;
                        });
                      },
                      keyboardType: TextInputType.multiline,
                      validator: (String arg) {
                        if (arg.length < 1)
                          return 'Deskripsi Produk Harus di isi';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Deskripsi produk',
                        labelText: 'Deskripsi produk',
                        labelStyle: TextStyle(fontSize: 16),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      child: Text("Simpan"),
                      color: Color(0xffb16a085),
                      textColor: Colors.white,
                      padding: EdgeInsets.only(left: 11, right: 11, top: 15, bottom: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      onPressed: () async {
                        _formKey.currentState.save();
                        if (_formKey.currentState.validate()) {
                          String fileNameFoto = foto.path.split('/').last;
                          String fileNameFoto1 = foto1.path.split('/').last;
                          String fileNameFoto2 = foto2.path.split('/').last;
                          var body = {
                            'nama': nama.toString(),
                            'berat': berat.toString(),
                            'foto': fileNameFoto.toString(),
                            'foto1': fileNameFoto1.toString(),
                            'foto2': fileNameFoto2.toString(),
                            'jenis_ongkir': jenis_ongkir.toString(),
                            'deskripsi': deskripsi.toString(),
                            'id_kategori': id_kategori.toString(),
                            'id_toko': blocAuth.idToko.toString(),
                            'kondisi': kondisi.toString(),
                            'minimal_pesanan': minimal_pesanan.toString(),
                            'harga': harga.toString(),
                            'stok': stok.toString(),
                          };
                          List<File> files = [foto, foto1, foto2];
                          var result = await blocProduk.addProduk(files, body);
                          if (result) {
                            setState(() {
                              success = true;
                            });
                            await Future.delayed(Duration(seconds: 1), () {
                              Navigator.pop(context);
                            });
                          } else {
                            setState(() {
                              error = true;
                            });
                            await Future.delayed(Duration(seconds: 1), () {
                              setState(() {
                                error = false;
                              });
                            });
                          }
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openImagePickerModal(BuildContext context, param) {
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

  void _getImage(BuildContext context, ImageSource source, param) async {
    File image = await ImagePicker.pickImage(source: source, maxHeight: 1000, maxWidth: 1000, imageQuality: 100);
    if (param == 'foto') {
      setState(() {
        foto = image;
      });
    } else if (param == 'foto1') {
      setState(() {
        foto1 = image;
      });
    } else if (param == 'foto2') {
      setState(() {
        foto2 = image;
      });
    }
    Navigator.pop(context);
  }
}
