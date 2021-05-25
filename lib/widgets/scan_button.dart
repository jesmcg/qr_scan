import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/db_provider.dart';

import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(Icons.filter_center_focus),
      onPressed: () async {
        // String barcodeScanerRes = await FlutterBarcodeScanner.scanBarcode(
        //     '#3D8BEF', 'Cancelar', false, ScanMode.QR);
        // final barcodeScanerRes = 'https://www.ricardosalinas.com/';
        final barcodeScanerRes = 'geo:19.304715608723537,-99.20383410872297';

        if (barcodeScanerRes == '-1') {
          return;
        }

        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);

        final ScanModel nuevoScan =
            await scanListProvider.nuevoScan(barcodeScanerRes);
        // scanListProvider.nuevoScan('geo:19.304715608723537,-99.20383410872297');
        print(barcodeScanerRes);

        launchURL(context, nuevoScan);
      },
    );
  }
}
