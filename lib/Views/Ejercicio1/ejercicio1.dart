import 'dart:io';
import 'package:evaluacion_tres_astronautas/Views/Components/footer.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Ejercicio1 extends StatefulWidget{
  _Ejercicio1 createState()=>new _Ejercicio1();
}
class _Ejercicio1 extends State<Ejercicio1>{
  Widget footerG = Container();
  @override
  void initState() {
    super.initState();
    setState(() {
      footerG=FooterGeneral(screen: 'ejercicio1');
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=> exit(0),
      child: Scaffold(
        backgroundColor: HexColor('fafafa'),
        body: Center(
          child: Text("ejercicio1"),
        ),
        bottomNavigationBar: footerG,
      ),
    );
  }

}