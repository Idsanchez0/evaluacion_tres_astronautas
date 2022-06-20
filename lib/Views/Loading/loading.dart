import 'dart:io';
import 'package:evaluacion_tres_astronautas/SizeConfig/SizeConfig.dart';
import 'package:evaluacion_tres_astronautas/Views/Ejercicio1/ejercicio1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Loading extends StatefulWidget{
  _Loading createState()=>new _Loading();
}
class _Loading extends State<Loading>{
  final _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    new Future.delayed(new Duration(seconds: 5), () {
      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Ejercicio1()));
    });
  }

  @override
  Widget build(BuildContext context) {
    //Logo//
    Widget loadingPage= Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/loading/cargando.gif'),
            fit: BoxFit.cover
          )
      ),
    );
    // TODO: implement build
    bool shouldPop = true;
    return WillPopScope(
      onWillPop: ()async{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>exit(0)));
        return shouldPop;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _globalKey,
        body: Center(
          child: Container(
            color: Colors.white,
            child: loadingPage,
          ),
        ),
      ),
    );
  }
}