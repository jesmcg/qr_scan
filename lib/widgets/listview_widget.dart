import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

class ListViewWidget extends StatefulWidget {
  const ListViewWidget({@required this.tipo});

  final String? tipo;

  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  late final SlidableController? slidableController;

  void initState() {
    this.slidableController = SlidableController(
        onSlideAnimationChanged: handleSlideAnimationChanged);
    super.initState();
  }

  Animation<double>? _rotationAnimation;
  Color _fabColor = Colors.blue;

  void handleSlideAnimationChanged(Animation<double>? slideAnimation) {
    setState(() {
      _rotationAnimation = slideAnimation;
    });
  }

  void handleSlideIsOpenChanged(bool? isOpen) {
    setState(() {
      _fabColor = isOpen! ? Colors.green : Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scanProvider = Provider.of<ScanListProvider>(context);
    final scans = scanProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i) => Slidable(
        key: ValueKey(0),
        dismissal: SlidableDismissal(
          child: SlidableDrawerDismissal(),
          onDismissed: (actionType) {
            Provider.of<ScanListProvider>(context, listen: false)
                .borrarScanPorId(scans[i].id!);
          },
        ),
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          child: ListTile(
            leading: Icon(
              this.widget.tipo == 'http'
                  ? Icons.map_outlined
                  : Icons.home_outlined,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(scans[i].valor!),
            subtitle: Text('ID: ${scans[i].id}'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () => print('ID: ${scans[i].id}'),
          ),
        ),
        actions: <Widget>[
          IconSlideAction(
            caption: 'Archive',
            color: Colors.blue,
            icon: Icons.archive,
            onTap: () => print('-- Action ---'),
          ),
          IconSlideAction(
            caption: 'Share',
            color: Colors.indigo,
            icon: Icons.share,
            onTap: () => print('-- Action ---'),
          ),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'More',
            color: Colors.black45,
            icon: Icons.more_horiz,
            onTap: () => print('-- Action Secondary ---'),
          ),
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => print('--- Delete --'),
          ),
        ],
      ),
    );
  }
}

// Dismissible(
//         background: Container(
//           color: Colors.red,
//         ),
//         key: UniqueKey(),
//         onDismissed: (DismissDirection direction) {
//           Provider.of<ScanListProvider>(context, listen: false)
//               .borrarScanPorId(scans[i].id);
//         },
//         child: ListTile(
//           leading: Icon(
//             this.tipo == 'http' ? Icons.map_outlined : Icons.home_outlined,
//             color: Theme.of(context).primaryColor,
//           ),
//           title: Text(scans[i].valor),
//           subtitle: Text('ID: ${scans[i].id}'),
//           trailing: Icon(Icons.keyboard_arrow_right),
//           onTap: () => print('ID: ${scans[i].id}'),
//         ),
//       ),
