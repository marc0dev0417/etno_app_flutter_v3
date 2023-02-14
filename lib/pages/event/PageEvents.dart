import 'package:etno_app/widgets/bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../store/section.dart';
import '../../widgets/appbar_navigation.dart';
import '../../widgets/home_widgets.dart';

class PageEvents extends StatefulWidget {
  const PageEvents({super.key});

  @override
  State<StatefulWidget> createState() {
   return PageState();
  }
}

class PageState extends State<PageEvents> {
  final Section section = Section();
  int tabIndex = 0;
  
  @override
  void initState() {
    section.getAllEventsByLocality('Bolea');
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom('Eventos', Icons.language, () => null),
      bottomNavigationBar: bottomNavigation(context, 1),
      body: Column(
        children: [
          Image.asset('assets/event.jpg'),
          Expanded(
              child: Observer(builder: (context) => GridView.count(
                crossAxisCount: 2,
                children: section.getListEvent.map((e) => Center(
                  child: SizedBox(
                    width: 200.0,
                    height: 200.0,
                    child: InkWell(
                      onTap: () => section.getEventByUsernameAndTitle(e.username!, e.title!).then((value) =>
                          showDialogEvent(context, value)
                      ),
                      child: Card(
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(e.imageUrl!), fit: BoxFit.fill)),
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(color: Colors.red),
                                child: Row(
                                    children: [
                                      const Icon(Icons.celebration, color: Colors.white),
                                      const SizedBox(width: 4.0),
                                      Text(e.title!.length < 19 ? e.title! : e.title!.substring(0, 19), style: const TextStyle(color: Colors.white))
                                    ]
                                ),
                              )
                            )
                      ),
                    ),
                  )
                )).toList()
              ))
          )
        ],
      ),
    );
  }
}