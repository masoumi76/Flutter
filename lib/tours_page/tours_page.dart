import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/Models.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/tours_page/tours_widgets.dart';

class Tours extends StatefulWidget {
  Tours({Key key}) : super(key: key);

  @override
  _ToursState createState() => _ToursState();
}

enum TourType { all, my, fav }

class _ToursState extends State<Tours> {
  TourType _type = TourType.all;

  Widget _topInfo() {
    return Container(
      height: SizeConfig.safeBlockVertical *
          (SizeConfig.orientationDevice == Orientation.portrait ? 30 : 45),
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/product_tour.png')),
          ),
        ),
      ),
    );
  }

  Widget _customButtons(String text, TourType type) {
    var selected = _type == type;
    return FlatButton(
      //textColor: Colors.black,
      //disabledTextColor: Colors.green,
      splashColor: Colors.red[200],
      child: Text(text,
          style: TextStyle(
              color: (selected ? Colors.red[500] : Colors.black),
              fontSize: (SizeConfig.orientationDevice == Orientation.portrait
                  ? 16
                  : 19))),
      onPressed: () => setState(() {
        _type = type;
      }),
    );
  }

  Widget _bottomInfo() {
    return Container(
      //height: SizeConfig.safeBlockVertical * 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      child: Column(
        children: <Widget>[
          ButtonBar(
            buttonMinWidth: 100,
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              _customButtons("Alle", TourType.all),
              _customButtons("Eigene", TourType.my),
              _customButtons("Favoriten", TourType.fav),
            ],
          ),
          TourList(_type),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ListView(
      children: <Widget>[
        _topInfo(),
        _bottomInfo(),
      ],
    );
  }
}

