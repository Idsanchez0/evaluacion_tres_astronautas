import 'dart:io';
import 'package:evaluacion_tres_astronautas/SizeConfig/SizeConfig.dart';
import 'package:evaluacion_tres_astronautas/Views/Ejercicio1/ejercicio1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loading extends StatefulWidget{
  _Loading createState()=>new _Loading();
}
class _Loading extends State<Loading>{
  final _globalKey = GlobalKey<ScaffoldState>();
  var _lan;
  getData() async {
    SharedPreferences lanpref = await SharedPreferences.getInstance();
    setState(() {
      _lan = lanpref.getString('idioma');
    });
    setData();
  }

  setData()async{
    if(_lan.toString()=='' || _lan.toString()=='null'){
      SharedPreferences idioma= await SharedPreferences.getInstance();
      idioma.setString('idioma', 'es');
    }else{
      SharedPreferences idioma= await SharedPreferences.getInstance();
      idioma.setString('idioma', _lan.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    Future.delayed(new Duration(seconds: 5), () {
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