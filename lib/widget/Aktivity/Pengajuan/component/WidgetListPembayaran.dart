import 'dart:io';
import 'package:apps/Utils/PreviewFoto.dart';
import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/models/TagihanM.dart';
import 'package:apps/providers/BlocProject.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';

class WidgetListPembayaran extends StatelessWidget {
  WidgetListPembayaran({Key key, this.param, this.foto}) : super(key: key);
  final Map<String, String> param;
  File foto;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocProject blocProject = Provider.of<BlocProject>(context);
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
    var totalTagihan = '';
    blocProject.listBids.forEach((element) => {
          if (element.status == '1') {totalTagihan = element.harga}
        });
    return ExpansionTileCard(
      elevation: 2,
      colorCurve: Curves.ease,
      initiallyExpanded: true,
      leading: Icon(
        Icons.payment,
        color: Colors.green,
      ),
      title: Text('Pembayaran '),
      subtitle: Text(
        totalTagihan == '' ? '0' : Money.fromInt(int.parse(totalTagihan), IDR).toString(),
        style: TextStyle(color: Colors.green),
      ),
      children: <Widget>[
        Divider(
          thickness: 1.0,
          height: 1.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: ListView.builder(
                  itemCount: blocProject.listTagihan.length,
                  itemBuilder: (context, index) {
                    var foto = baseURL + pathBaseUrl + 'assets/tagihan/' + blocProject.listTagihan[index].foto.toString();
                    var termin = (int.parse(totalTagihan == '' ? '0' : totalTagihan) / 100 * int.parse(blocProject.listTagihan[index].percentase));
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteTransition(
                              animationType: AnimationType.slide_down,
                              builder: (context) => PreviewFoto(urlFoto: foto == null ? dataProvider.fotoNull : foto),
                            ));
                      },
                      leading: Image.network(
                        baseURL + pathBaseUrl + 'assets/tagihan/' + blocProject.listTagihan[index].foto.toString(),
                        height: 45,
                        width: 45,
                        errorBuilder: (context, urlImage, error) {
                          return Image.network(
                            dataProvider.fotoNull,
                            height: 45,
                            width: 45,
                          );
                        },
                      ),
                      title: Text(blocProject.listTagihan[index].nama),
                      subtitle: Text(blocProject.listTagihan[index].percentase + '% = ' + Money.fromInt(termin.round(), IDR).toString()),
                      trailing: Container(
                        height: 30,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Text(
                            'Upload',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            blocProject.listProjectDetail[0].status == 'selesai' ? null : _chooseImage(context, blocProject.listTagihan[index]);
                          },
                          color: blocProject.listProjectDetail[0].status == 'selesai' ? Colors.grey : Colors.cyan[800],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        )
      ],
    );
  }

  void _chooseImage(context, TagihanM param) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    openImagePickerModal(context, param);
  }

  void openImagePickerModal(BuildContext context, TagihanM param) {
    var file;
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
    return file;
  }

  void _getImage(BuildContext context, ImageSource source, TagihanM param) async {
    File image = await ImagePicker.pickImage(source: source, maxHeight: 1000, maxWidth: 1000, imageQuality: 50);
    Navigator.pop(context);
    _cropImage(image, context, param);
  }

  Future<Null> _cropImage(imageFile, context, TagihanM param) async {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    BlocProject blocProject = Provider.of<BlocProject>(context);
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [CropAspectRatioPreset.square, CropAspectRatioPreset.ratio3x2, CropAspectRatioPreset.original, CropAspectRatioPreset.ratio4x3, CropAspectRatioPreset.ratio16x9]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper', toolbarColor: Colors.deepOrange, toolbarWidgetColor: Colors.white, initAspectRatio: CropAspectRatioPreset.original, lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      dataProvider.setFile(croppedFile);
      var body = {'id': param.id, 'foto': croppedFile.path.split('/').last};
      List<File> files = [croppedFile];
      dataProvider.setUpload(true);
      var result = blocProject.uploadTermin(files, body);
      result.then((value) {
        if (value['meta']['success']) {
          blocProject.getProjectByOrder({'id': param.idProyek.toString()});
          blocProject.getTagihanByParam({'id_proyek': param.idProyek.toString()});
        }
      });
    }
  }

  void _clearImage(context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    dataProvider.setFile(null);
  }
}
