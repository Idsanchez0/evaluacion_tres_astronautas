import 'package:evaluacion_tres_astronautas/SizeConfig/SizeConfig.dart';
import 'package:evaluacion_tres_astronautas/Views/Ejercicio1/ejercicio1.dart';
import 'package:evaluacion_tres_astronautas/Views/Ejercicio2/ejercicio2.dart';
import 'package:evaluacion_tres_astronautas/Views/Extra/calendario.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';

class FooterGeneral extends StatefulWidget{
  var screen;
  FooterGeneral({this.screen}):super();
  _FooterGeneral createState()=>new _FooterGeneral();
}
class _FooterGeneral extends State<FooterGeneral>{
  var _screen;
  @override
  void initState() {
    super.initState();
    Remplazo(widget.screen);
  }

  Remplazo(var screen){
    setState(() {
      _screen=screen;
    });
  }


  DatosError(BuildContext context, String text) {
    AlertDialog alert = AlertDialog(
      title: Text("Alerta",
        style: TextStyle(
          fontSize: 2.5*SizeConfig.textMultiplier,
          fontFamily: 'Gothic',
        ),
      ),
      content: Text(text,
        style: TextStyle(
          fontSize: 1.9*SizeConfig.textMultiplier,
          fontFamily: 'Gothic',
        ),
      ),
      actions: [
        TextButton(
          child: Text("Aceptar",
            style: TextStyle(
              fontFamily: 'Gothic',
              fontSize: 1.9*SizeConfig.textMultiplier,
            ),
          ),
          onPressed:  () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future ErrorPopUp(String text){
    return showDialog(
      context: this.context,
      builder: (BuildContext context){
        return Center(
          //backgroundColor: Colors.blue,
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                height: 25*SizeConfig.heightMultiplier,
                width: 80*SizeConfig.widthMultiplier,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5*SizeConfig.widthMultiplier)),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 3*SizeConfig.heightMultiplier),
                      child: Column(
                        children: [
                          Container(
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: InkWell(
                                  onTap: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                      width: 10*SizeConfig.widthMultiplier,
                                      height: 10*SizeConfig.imageSizeMultiplier,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.all(Radius.circular(50*SizeConfig.widthMultiplier))
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Center(
                                          child: Icon(Icons.warning_amber_outlined, color: Colors.white),
                                        ),
                                      )
                                  ),
                                ),
                              )
                          ),
                          Container(
                              padding: EdgeInsets.only(top: 2*SizeConfig.heightMultiplier, left: 2*SizeConfig.widthMultiplier, right: 2*SizeConfig.widthMultiplier),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(color: HexColor("253166"))
                                    )
                                ),
                                child: Text(text,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: HexColor("253166"),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 2.5*SizeConfig.textMultiplier,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              )
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 3*SizeConfig.heightMultiplier),
                            child: InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 60*SizeConfig.widthMultiplier,
                                height: 5*SizeConfig.heightMultiplier,
                                decoration: BoxDecoration(
                                    color: HexColor('e0844c'),
                                    borderRadius: BorderRadius.all(Radius.circular(50*SizeConfig.widthMultiplier))
                                ),
                                child: Center(
                                  child: Text("Accept",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 2.5*SizeConfig.textMultiplier,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 15,
        child: Container(
          color: Colors.white,
          height: 8.5*SizeConfig.heightMultiplier,
          width: 95*SizeConfig.widthMultiplier,
          margin: EdgeInsets.only(top: 0*SizeConfig.heightMultiplier),
          padding: EdgeInsets.only(top: 0*SizeConfig.heightMultiplier, bottom: 0*SizeConfig.heightMultiplier),
          child: Container(
            child: Table(
              columnWidths: {
                0:FlexColumnWidth(1),
                1:FlexColumnWidth(1),
                2:FlexColumnWidth(1),
                3:FlexColumnWidth(2),
                4:FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  children: [
                    Container(
                      child: Container(
                        padding: EdgeInsets.only(top: 1.5*SizeConfig.heightMultiplier),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Ejercicio1()));
                          },
                          child: Image(
                            image: _screen.toString()=='ejercicio1'?AssetImage('images/icons/casa2.png'):AssetImage('images/icons/casa.png'),
                            height: 7*SizeConfig.imageSizeMultiplier,
                          ),
                        )
                      )
                    ),
                    Container(
                      child: Container(
                        padding: EdgeInsets.only(top: 1.5*SizeConfig.heightMultiplier),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Calendario()));
                          },
                          child: Image(
                            image: _screen=='calendario'?AssetImage('images/icons/calendario2.png'):AssetImage('images/icons/calendario.png'),
                            height: 7*SizeConfig.imageSizeMultiplier,
                          ),
                        )
                      ),
                    ),
                    Container(
                      child: Container(
                        padding: EdgeInsets.only(top: 1.5*SizeConfig.heightMultiplier),
                        child: InkWell(
                            onTap: (){
                              ErrorPopUp('Disabled function');
                            },
                          child: Image(
                            image: _screen=='ejercici42'?AssetImage('images/icons/zoom2.png'):AssetImage('images/icons/zoom.png'),
                            height: 7*SizeConfig.imageSizeMultiplier,
                          )
                        ),
                      )
                    ),
                    Container(
                      child: Container(
                          padding: EdgeInsets.only(top: 1.5*SizeConfig.heightMultiplier),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Ejercicio2()));
                            },
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 3.2*SizeConfig.widthMultiplier),
                                  child: Image(
                                    image: _screen=='ejercicio2'?AssetImage('images/icons/heart2.png'):AssetImage('images/icons/heart.png'),
                                    height: 7*SizeConfig.imageSizeMultiplier,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 3*SizeConfig.widthMultiplier),
                                  child: Text('Favoritos',
                                    style: TextStyle(
                                        color: _screen=='ejercicio2'?HexColor('e0844c'):Colors.black,
                                        fontSize: 1.9*SizeConfig.textMultiplier,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )
                              ],
                            )
                          )
                      ),
                    ),
                  ]
                )
              ],
            ),
          ),
        )
    );
  }
}