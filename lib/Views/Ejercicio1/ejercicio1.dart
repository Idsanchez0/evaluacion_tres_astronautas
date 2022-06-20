import 'dart:io';
import 'dart:math';
import 'package:evaluacion_tres_astronautas/Views/Components/footer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:evaluacion_tres_astronautas/SizeConfig/SizeConfig.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ejercicio1 extends StatefulWidget{
  _Ejercicio1 createState()=>new _Ejercicio1();
}
class _Ejercicio1 extends State<Ejercicio1>{
  Widget footerG = Container();
  int _entryData=0;
  Random random = Random();
  List<List<int>> matrix = [];
  List<Widget> myMatrix=[];
  int contador=0;
  TextEditingController dataController= TextEditingController();
  var _lan;

  getData() async {
    SharedPreferences lanpref = await SharedPreferences.getInstance();
    setState(() {
      _lan = lanpref.getString('idioma');
      footerG=FooterGeneral(screen: 'ejercicio1');
    });
  }
  @override
  void initState() {
    super.initState();
    getData();
  }

  CalculateIsland(){
    setState(() {
      contador=0;
    });
    for (var i = 0; i < matrix.length; i++) {
      for (var j = 0; j < matrix.length; j++) {
        if(matrix[i][j]==1){
          contador++;
        }
      }
    }
  }

  ActionsSheet(BuildContext context){
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context){
          return CupertinoActionSheet(
            title: Text(_lan.toString()=='es'?'Idioma':'Language'),
            actions:<CupertinoActionSheetAction> [
              CupertinoActionSheetAction(
                isDefaultAction: true,
                onPressed: ()async{
                  SharedPreferences idiomapref= await SharedPreferences.getInstance();
                  idiomapref.setString('idioma', 'en');
                  setState(() {
                    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Ejercicio1()));
                  });
                },
                child: Container(
                  child: Text(_lan.toString()=='es'?'Inglés':'English'),
                ),

              ),
              CupertinoActionSheetAction(
                isDefaultAction: true,
                onPressed: ()async{
                  SharedPreferences idiomapref= await SharedPreferences.getInstance();
                  idiomapref.setString('idioma', 'es');
                  setState(() {
                    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Ejercicio1()));
                  });
                },
                child: Container(
                  child: Text(_lan.toString()=='es'?'Español':'Spanish'),
                ),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Container(
                child: Text(_lan.toString()=='es'?'Cancelar':'Cancel'),
              ),
            ),
          );
        }
    );
  }

  //PopUpError
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
                                  child: Text(_lan=='es'?"Aceptar":"Accept",
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
    Widget Header=Container(
        padding: EdgeInsets.only(left: 4*SizeConfig.widthMultiplier, right: 4*SizeConfig.widthMultiplier),
        width: double.infinity,
        color: HexColor('f4f4f4'),
        child: Container(
            padding: EdgeInsets.only(top: 5*SizeConfig.heightMultiplier),
            child: Table(
              columnWidths: {
                0:FlexColumnWidth(5),
                1:FlexColumnWidth(2),
                2:FlexColumnWidth(2),
              },
              children: [
                TableRow(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 40*SizeConfig.widthMultiplier),
                        child: Image(
                          image: AssetImage("images/icons/nasa.png"),
                          height: 25*SizeConfig.imageSizeMultiplier,
                        ),
                      ),
                      Container(
                        child: Table(
                          children: [
                            TableRow(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 3.5*SizeConfig.heightMultiplier),
                                    child: InkWell(
                                      onTap: (){
                                        ErrorPopUp(_lan=='es'?"Las notificaciones no están activadas":'Notifications are not enabled');
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(2*SizeConfig.imageSizeMultiplier),
                                          height: 5*SizeConfig.heightMultiplier,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: kElevationToShadow[2],
                                          ),
                                          child: Image(
                                            image: AssetImage('images/icons/notification.png'),
                                          )
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 3.5*SizeConfig.heightMultiplier),
                                    child: InkWell(
                                      onTap: (){
                                        ActionsSheet(context);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(2*SizeConfig.imageSizeMultiplier),
                                        height: 5*SizeConfig.heightMultiplier,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: kElevationToShadow[2],
                                        ),
                                        child: Image(
                                          image: AssetImage('images/icons/ajustes.png'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]
                            )
                          ],
                        ),
                      )
                    ]
                )
              ],
            )
        )
    );
    Widget Title=Container(
        padding: EdgeInsets.only(left: 4*SizeConfig.widthMultiplier, right: 4*SizeConfig.widthMultiplier, bottom: 1*SizeConfig.heightMultiplier),
        width: double.infinity,
        color: HexColor('f4f4f4'),
        child: Container(
          child: Container(
            margin: EdgeInsets.only(top: 1.5*SizeConfig.heightMultiplier),
            child: Text(_lan=='es'?"Ejercicio 1":"Exercise 1",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 3.5*SizeConfig.textMultiplier,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        )
    );
    myMatrix=matrix
        .map((columns) => Column(
            children: columns.map((nr) => InkWell(
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 0*SizeConfig.widthMultiplier),
                width: 15*SizeConfig.widthMultiplier,
                height: 8*SizeConfig.heightMultiplier,
                color: nr.toString()=='0'?Colors.blue:Colors.green,
                child: Text(nr.toString()+'s',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color:HexColor('ffffff'),
                    )
                ),
              )
            )).toList(),
          )
        ).toList();
    Widget EntryData=Container(
      color: HexColor('f4f4f4'),
      child: Container(
        margin: EdgeInsets.only(top: 1*SizeConfig.heightMultiplier),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5*SizeConfig.widthMultiplier),
              topLeft: Radius.circular(5*SizeConfig.widthMultiplier),
            ),
            border: Border.all(color: Colors.white)
        ),
        padding: EdgeInsets.only(left: 4*SizeConfig.widthMultiplier, right: 4*SizeConfig.widthMultiplier, bottom: 1*SizeConfig.heightMultiplier),
        child: Container(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 2*SizeConfig.heightMultiplier),
                  child: Table(
                    columnWidths: {
                      0:FlexColumnWidth(2),
                      1:FlexColumnWidth(2)
                    },
                    children: [
                      TableRow(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 3*SizeConfig.heightMultiplier),
                              alignment: Alignment.centerLeft,
                              child: Text(_lan=='es'?"Número de entradas":'Number of entries',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 1.5*SizeConfig.textMultiplier,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 1.5*SizeConfig.heightMultiplier),
                              height: 6*SizeConfig.heightMultiplier,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(2*SizeConfig.widthMultiplier)),
                                  color:Colors.white
                              ),
                              child: TextFormField(
                                textAlignVertical: TextAlignVertical.bottom,
                                controller: dataController,
                                textAlign: TextAlign.left,
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: "",
                                  hintStyle: TextStyle(
                                    fontSize: 2*SizeConfig.textMultiplier,
                                    fontFamily: 'Gothic',
                                  ),
                                  isDense:true,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(2*SizeConfig.widthMultiplier))),
                                ),
                                style: TextStyle(
                                    fontSize: 1.8*SizeConfig.textMultiplier,
                                    fontFamily: 'Gothic',
                                    color: HexColor('616163')
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2*SizeConfig.heightMultiplier),
                              child: InkWell(
                                onTap: (){
                                  matrix.clear();
                                  setState(() {
                                    _entryData=int.parse(dataController.text.toString());
                                  });
                                  for (var i = 0; i < _entryData; i++) {
                                    List<int> list = [];
                                    for (var j = 0; j < _entryData; j++) {
                                      list.add(random.nextInt(2));
                                    }
                                    matrix.add(list);
                                  }
                                  CalculateIsland();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(2*SizeConfig.imageSizeMultiplier),
                                  height: 5*SizeConfig.heightMultiplier,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: kElevationToShadow[2],
                                  ),
                                  child: Icon(Icons.send, color: Colors.black,),
                                ),
                              ),
                            ),
                          ]
                      )
                    ],
                  )
              ),
              Container(
                width: double.infinity,
                height: 45*SizeConfig.heightMultiplier,
                margin: EdgeInsets.only(top: 2*SizeConfig.heightMultiplier),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: myMatrix,
                        ),
                      )
                    ],
                  )
                )
              ),
              Container(
                margin: EdgeInsets.only(top: 2*SizeConfig.heightMultiplier),
                child: Row(
                  children: [
                    Container(
                      child: Text(_lan=='es'?"Total de Islas: ":'Total Island: ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 2*SizeConfig.textMultiplier,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(''+contador.toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 2*SizeConfig.textMultiplier,
                        ),
                      ),
                    )
                  ],
                )
              )
            ],
          ),
        ),
      )
    );
    return WillPopScope(
      onWillPop: ()=> exit(0),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            color: Colors.transparent,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Header,
                  Title,
                  EntryData,
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: footerG,
      ),
    );
  }

}