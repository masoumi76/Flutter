import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/add_tour/edit_tour.dart';
import 'package:museum_app/database/database.dart';
import 'package:museum_app/museum_tabs.dart';

import 'create_tour.dart';

class AddTour extends StatefulWidget {
  AddTour({Key key}) : super(key: key);

  @override
  _AddTourState createState() => _AddTourState();
}

enum AddType { CHOOSE, CREATE, EDIT }

class _AddTourState extends State<AddTour> {
  AddType _type = AddType.CHOOSE;

  void goBack() => setState(() => _type = AddType.CHOOSE);

  @override
  Widget build(BuildContext context) {
    switch (_type) {
      case AddType.CREATE:
        return StreamBuilder(
          stream: MuseumDatabase.get().watchUser(),
          builder: (context, snap) {
            var name = snap.data?.username ?? "";
            return CreateTour(goBack, TourWithStops.empty(name));
          },
        );
      case AddType.EDIT:
        return EditTour(goBack);
      default:
        return MuseumTabs.single(
          Center(child: Text("SCHÖNES BILD")),
          _chooseState(), //TestWidget()],
          //names: ["Erstellen", "Beitreten"],
          //color: Colors.orange,
        );
    }
  }

  Widget _chooseState() {
    var margin = EdgeInsets.only(bottom: 15);
    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0, bottom: 10.0),
      child: Column(
        children: [
          border(
              _content(
                  "img",
                  "Tour erstellen",
                  "Erstelle Deine eigene Tour durch das Landesmuseum.",
                  "Neue Tour erstellen",
                  () => setState(() => _type = AddType.CREATE)),
              margin: margin),
          border(
              _content(
                  "img2",
                  "Tour bearbeiten",
                  "Bearbeite eine Deiner Touren oder ergänze sie um Stationen.",
                  "Touren bearbeiten",
                  () => setState(() => _type = AddType.EDIT)),
              margin: margin),
          border(
              GestureDetector(
                onTap: () => print("Video Erklär Tour"),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: horSize(27, 30),
                      child: Text("jj"),
                    ),
                    Container(
                      width: horSize(57, 60),
                      child: Text(
                        "Noch Fragen?\nSchau Dir ein Erklärvideo zur Tour-Erstellung an!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
              margin: margin)
        ],
      ),
    );
  }

  Widget _content(
      String img, String title, String descr, String btnText, action) {
    return Row(
      children: [
        Container(
          width: horSize(34, 10),
          child: Text(img),
        ),
        Container(
          margin: EdgeInsets.only(left: 8),
          width: horSize(48, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(descr),
              FlatButton(
                onPressed: action,
                child: Text(btnText),
                color: Colors.orange,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

Widget border(Widget w,
    {width, height, margin, padding = const EdgeInsets.all(8)}) {
  return Container(
    width: width,
    height: height,
    padding: padding,
    margin: margin,
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.orange, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset.fromDirection(pi / 2),
          )
        ]),
    child: w,
  );
}
