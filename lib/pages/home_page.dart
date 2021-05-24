import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

import 'package:qr_reader/pages/direccione_page.dart';
import 'package:qr_reader/pages/mapas_page.dart';

import 'package:qr_reader/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () {
                Provider.of<ScanListProvider>(context, listen: false)
                    .borrarTodos();
              })
        ],
        title: Text('Hitorial'),
      ),
      body: _HomePageBody(),
      // bottomNavigationBar: BottomNavigationBar(),
      bottomNavigationBar: CustomNavigationBarWidget(),
      floatingActionButton: ScanButtonWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);

    // Cambiar para mostar la pagina respectiva
    final currentIndex = uiProvider.selectedMenuOpt;

    // TODOS: Temporal leer database
    // final tempScan = new ScanModel(valor: 'http://www.google.com');
    // DBProvider.db.nuevoScan(tempScan);

    // final tempScan =
    //     new ScanModel(id: 8, valor: 'https://www.feranandoerrera.com');
    // DBProvider.db.updateScan(tempScan);

    // DBProvider.db.deleteScanRaw().then(print);

    // DBProvider.db.getScanById(8).then((value) => print(value.valor));

    // DBProvider.db.getScanByTipo('http').then(print);

    /**
     *   */
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansPorTipo('geo');
        return MapasPage();
      case 1:
        scanListProvider.cargarScansPorTipo('http');
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }
}
