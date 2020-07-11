import 'package:apps/providers/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';

class WidgetInvoice extends StatelessWidget {
  WidgetInvoice({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice'),
      ),
      body: dataProvider.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SafeArea(
                child: ListView.builder(
                  itemCount: dataProvider.invoiceListData.length,
                  itemBuilder: (context, index) {
                    final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
                    var invoiceStatus = dataProvider.invoiceListData[index].invoiceStatus;
                    var invoiceNominal = Money.fromInt(dataProvider.invoiceListData[index].invoiceNominal == null ? 0 : int.parse(dataProvider.invoiceListData[index].invoiceNominal), IDR);
                    return //              Card(
                        Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            invoiceNominal.toString(),
                            style: TextStyle(color: Colors.green),
                          ),
                          subtitle: Text(dataProvider.invoiceListData[index].invoiceDeskripsi),
                          trailing: Text(
                            dataProvider.invoiceListData[index].invoiceStatus,
                            style: TextStyle(color: invoiceStatus == 'Pending'? Colors.red : Colors.green),
                          ),
                          leading: Icon(
                            Icons.credit_card,
                            size: 35,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
