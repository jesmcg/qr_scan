import 'package:flutter/material.dart';

import 'package:qr_reader/widgets/listview_widget.dart';

class DireccionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListViewWidget(tipo: 'geo');
  }
}
