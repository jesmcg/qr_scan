import 'package:flutter/material.dart';
import 'package:qr_reader/widgets/listview_widget.dart';

class MapasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListViewWidget(tipo: 'http');
  }
}
