import 'package:etno_app/store/section.dart';
import 'package:etno_app/utils/WarningWidgetValueNotifier.dart';
import 'package:etno_app/widgets/appbar_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../models/Bandos.dart';

class PageBandos extends StatefulWidget {
  const PageBandos({super.key});

  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}
class PageState extends State<PageBandos> {
  final Section section = Section();
  @override
  void initState() {
    section.getAllBandosByLocality('Bolea');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom('Bandos', Icons.language, () => null),
      body: Column(
        children: [
          const WarningWidgetValueNotifier(),
          Container(
              padding: const EdgeInsets.all(15.0),
              child: Observer(builder: (context) {
                if(section.getBandos.isNotEmpty){
                  return ListView(
                      shrinkWrap: true,
                      children: section.getBandos.map((e) => carBando(e, context)).toList()
                  );
                }else{
                  return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 250.0),
                      child: Column(
                          children: const [
                            Text('No hay Bandos disponibles'),
                            Icon(Icons.block, size: 120.0)
                          ]
                      )
                  );
                }
              })
          ),
        ]
      )
    );
  }
}
Widget carBando(Bandos bandos, BuildContext context){
  return SizedBox(
    height: 60,
    child: InkWell(
      onTap: () { showDialogBandos(context, bandos); },
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.campaign, color: Colors.red),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(bandos.title!, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(bandos.issuedDate!, style: const TextStyle(color: Colors.grey, fontSize: 12.0))
              ]
            ),
            const Icon(Icons.subdirectory_arrow_right, color: Colors.red)
          ]
        ),
      ),
    ),
  );
}

showDialogBandos(BuildContext context, Bandos bandos) => showBottomSheet(context: context, builder: (context){
  return Wrap(
    children: [
      Column(
        children: [
          Container(
              padding: const EdgeInsets.only(top: 15.0),
              child: bandos.imageUrl != null ? Image.network(bandos.imageUrl!, fit: BoxFit.fill) : const Icon(Icons.campaign, size: 80.0, color: Colors.red)
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(15.0),
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 15.0),
                        alignment: Alignment.topLeft,
                        child: Text(bandos.title!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 15.0),
                        alignment: Alignment.topLeft,
                        child: Text('${bandos.username} · Huesca', style: const TextStyle(color: Colors.grey, fontSize: 10.0)),
                      ),
                      const Divider(),
                      Container(
                        padding: const EdgeInsets.only(left: 15.0, top: 4.0),
                        alignment: Alignment.topLeft,
                        child: const Text('Emitido', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 15.0),
                        alignment: Alignment.topLeft,
                        child: Text(bandos.issuedDate!, style: const TextStyle(color: Colors.grey, fontSize: 10.0)),
                      ),
                      const Divider(),
                      Container(
                          padding: const EdgeInsets.only(left: 15.0),
                          alignment: Alignment.topLeft,
                          child: Text(
                              bandos.description!,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0)
                          )
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      )
    ],
  );
});