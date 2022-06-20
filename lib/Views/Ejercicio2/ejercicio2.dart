import 'dart:convert';
import 'dart:io';
import 'package:evaluacion_tres_astronautas/SizeConfig/SizeConfig.dart';
import 'package:evaluacion_tres_astronautas/Views/Components/footer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ejercicio2 extends StatefulWidget{
  _Ejercicio2 createState()=>new _Ejercicio2();
}
class _Ejercicio2 extends State<Ejercicio2>{
  Widget footerG = Container();
  var _gifs;
  var _tabs;
  bool _isLoading=false;
  var _lan;

  getData() async {
    SharedPreferences lanpref = await SharedPreferences.getInstance();
    setState(() {
      _lan = lanpref.getString('idioma');
      footerG=FooterGeneral(screen: 'ejercicio2');
      _tabs='restaurant';
    });
    GetGifs(_tabs.toString());
  }

  @override
  void initState() {
    super.initState();
    getData();
  }
  //
  GetGifs(String tab)async{
    setState(() {
      _isLoading=true;
    });
    final response =await http.get('https://api.giphy.com/v1/gifs/search?api_key=2rrHcN2q4fbw9NbJwh1WmOYq9NF830Jk&q=${tab.toString()}&limit=25&offset=0&rating=g&lang=en',);
    var responseData=json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        _gifs=responseData['data'];
        print(_gifs);
        _isLoading=false;
      });
    }else{
      print('Erro lista profesionales');
      ErrorPopUp(_lan=='es'?"Por favor intentalo más tarde":'Please try again later');
    }
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
  //PopUpFoto
  Future FotoPop(String name){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(2),
          content: Container(
            height: 70*SizeConfig.heightMultiplier,
            width: 200*SizeConfig.widthMultiplier,
            child: Column(
              children: <Widget>[
                Container(
                  height: 50*SizeConfig.heightMultiplier,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(name),
                        fit: BoxFit.fill,
                      )
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 2*SizeConfig.heightMultiplier),
                  width: double.infinity,
                  child: Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: (){
                          Navigator.pop(context,false);
                        },
                        child: Text(_lan=='es'?"Cerrar":"Close",
                          style: TextStyle(
                            fontSize: 3.5*SizeConfig.textMultiplier,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  //Languaje
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
                    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Ejercicio2()));
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
                    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Ejercicio2()));
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
                                      ActionsSheet(this.context);
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

    Widget Favorite=Container(
      padding: EdgeInsets.only(left: 4*SizeConfig.widthMultiplier, right: 4*SizeConfig.widthMultiplier, bottom: 1*SizeConfig.heightMultiplier),
      width: double.infinity,
      color: HexColor('f4f4f4'),
      child: Container(
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
                      margin: EdgeInsets.only(top: 3.5*SizeConfig.heightMultiplier),
                      child: Text(_lan=='es'?"Favoritos":"Favorites",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 3.5*SizeConfig.textMultiplier,
                            fontWeight: FontWeight.bold
                        ),
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
                                    child: Container(
                                        padding: EdgeInsets.all(2*SizeConfig.imageSizeMultiplier),
                                        height: 5*SizeConfig.heightMultiplier,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text("")
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 3.5*SizeConfig.heightMultiplier),
                                  child: InkWell(
                                    onTap: (){
                                      ErrorPopUp(_lan=='es'?"No se puede agregar más elementos a la lista":'You cannot add more items to the list');
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(2*SizeConfig.imageSizeMultiplier),
                                      height: 5*SizeConfig.heightMultiplier,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: kElevationToShadow[2],
                                      ),
                                      child: Icon(Icons.add, color: Colors.black,),
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

    Widget Tabs=Container(
        padding: EdgeInsets.only(left: 4*SizeConfig.widthMultiplier, right: 4*SizeConfig.widthMultiplier, bottom: 1*SizeConfig.heightMultiplier),
        width: double.infinity,
        color: HexColor('f4f4f4'),
      child: Container(
          margin: EdgeInsets.only(top: 2*SizeConfig.heightMultiplier),
          child: Table(
            columnWidths: {
              0:FlexColumnWidth(2),
              1:FlexColumnWidth(3),
              2:FlexColumnWidth(2),
              3:FlexColumnWidth(2)
            },
            children: [
              TableRow(
                  children: [
                    Container(
                        margin: EdgeInsets.only(right: 1*SizeConfig.widthMultiplier),
                        child: Hero(
                            tag: 'Tab1',
                            child: InkWell(
                              onTap: (){
                                setState(() {
                                  _tabs='restaurant';
                                });
                                GetGifs(_tabs);
                              },
                              child: Container(
                                  height: 5*SizeConfig.heightMultiplier,
                                  decoration: BoxDecoration(
                                    color: _tabs=='restaurant'?HexColor('e0844c'):Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(3.5*SizeConfig.widthMultiplier)),
                                    boxShadow: kElevationToShadow[2],
                                  ),
                                  child: Center(
                                    child: Text(_lan=='es'?"Todos":'All',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: _tabs=='restaurant'?Colors.white:Colors.black,
                                        fontSize: 2*SizeConfig.textMultiplier,
                                      ),
                                    ),
                                  )
                              ),
                            )
                        )
                    ),
                    Container(
                        margin: EdgeInsets.only(right: 1*SizeConfig.widthMultiplier),
                        child: Hero(
                            tag: "Tab2",
                            child: InkWell(
                              onTap: (){
                                setState(() {
                                  _tabs='happy hours';
                                });
                                GetGifs(_tabs);
                              },
                              child: Container(
                                  height: 5*SizeConfig.heightMultiplier,
                                  decoration: BoxDecoration(
                                    color: _tabs=='happy hours'?HexColor('e0844c'):Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(3.5*SizeConfig.widthMultiplier)),
                                    boxShadow: kElevationToShadow[2],
                                  ),
                                  child: Center(
                                    child: Text(_lan=='es'?"Hora Feliz":'Happy Hours',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: _tabs=='happy hours'?Colors.white:Colors.black,
                                        fontSize: 2*SizeConfig.textMultiplier,
                                      ),
                                    ),
                                  )
                              ),
                            )
                        )
                    ),
                    Container(
                        margin: EdgeInsets.only(right: 1*SizeConfig.widthMultiplier),
                        child: Hero(
                            tag: 'Tab3',
                            child: InkWell(
                              onTap: (){
                                setState(() {
                                  _tabs='drinks';
                                });
                                GetGifs(_tabs);
                              },
                              child: Container(
                                  height: 5*SizeConfig.heightMultiplier,
                                  decoration: BoxDecoration(
                                    color: _tabs=='drinks'?HexColor('e0844c'):Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(3.5*SizeConfig.widthMultiplier)),
                                    boxShadow: kElevationToShadow[2],
                                  ),
                                  child: Center(
                                    child: Text(_lan=='es'?"Bebidas":'Drinks',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: _tabs=='drinks'?Colors.white:Colors.black,
                                        fontSize: 2*SizeConfig.textMultiplier,
                                      ),
                                    ),
                                  )
                              ),
                            )
                        )
                    ),
                    Container(
                        child: Hero(
                            tag: 'Tab4',
                            child: InkWell(
                              onTap: (){
                                setState(() {
                                  _tabs='beer';
                                });
                                GetGifs(_tabs);
                              },
                              child: Container(
                                  height: 5*SizeConfig.heightMultiplier,
                                  decoration: BoxDecoration(
                                    color: _tabs=='beer'?HexColor('e0844c'):Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(3.5*SizeConfig.widthMultiplier)),
                                    boxShadow: kElevationToShadow[2],
                                  ),
                                  child: Center(
                                    child: Text(_lan=='es'?"Cerveza":'Beer',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: _tabs=='beer'?Colors.white:Colors.black,
                                        fontSize: 2*SizeConfig.textMultiplier,
                                      ),
                                    ),
                                  )
                              ),
                            )
                        )
                    ),
                  ]
              )
            ],
          )
      )
    );

    Widget TitleList=Container(
      width: double.infinity,
      color: HexColor('f4f4f4'),
      child: Container(
        margin: EdgeInsets.only(top: 2*SizeConfig.heightMultiplier),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5*SizeConfig.widthMultiplier),
              topLeft: Radius.circular(5*SizeConfig.widthMultiplier),
            ),
            border: Border.all(color: Colors.white)
        ),
        child: Container(
            padding: EdgeInsets.only(left: 4*SizeConfig.widthMultiplier, right: 4*SizeConfig.widthMultiplier, bottom: 1*SizeConfig.heightMultiplier),
            child: Table(
              columnWidths: {
                0:FlexColumnWidth(5),
                1:FlexColumnWidth(2),
                2:FlexColumnWidth(2),
              },
              children: [
                TableRow(
                    children: [
                      if(_tabs=='restaurant')
                        Container(
                          margin: EdgeInsets.only(top: 3.5*SizeConfig.heightMultiplier),
                          child: Text(_lan=='es'?"Todos":"All",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 3.5*SizeConfig.textMultiplier,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      else if(_tabs=='happy hours')
                        Container(
                          margin: EdgeInsets.only(top: 3.5*SizeConfig.heightMultiplier),
                          child: Text(_lan=='es'?"Hora Feliz":"Happy Hours",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 3.5*SizeConfig.textMultiplier,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      else if(_tabs=='drinks')
                          Container(
                            margin: EdgeInsets.only(top: 3.5*SizeConfig.heightMultiplier),
                            child: Text(_lan=='es'?"Bebidas":"Drinks",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 3.5*SizeConfig.textMultiplier,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                      else if(_tabs=='beer')
                            Container(
                              margin: EdgeInsets.only(top: 3.5*SizeConfig.heightMultiplier),
                              child: Text(_lan=='es'?"Cerveza":"Beer",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 3.5*SizeConfig.textMultiplier,
                                    fontWeight: FontWeight.bold
                                ),
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
                                      child: Container(
                                          padding: EdgeInsets.all(2*SizeConfig.imageSizeMultiplier),
                                          height: 5*SizeConfig.heightMultiplier,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Text("")
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 3.5*SizeConfig.heightMultiplier),
                                    child: InkWell(
                                      child: Container(
                                        padding: EdgeInsets.all(2*SizeConfig.imageSizeMultiplier),
                                        height: 5*SizeConfig.heightMultiplier,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: kElevationToShadow[2],
                                        ),
                                        child: Icon(Icons.delete_outline, color: Colors.black,),
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
        ),
      )
    );

    Widget ListApi=Container(
      margin: EdgeInsets.only(top: 0*SizeConfig.heightMultiplier),
      padding: EdgeInsets.only(top: 0*SizeConfig.heightMultiplier, left: 4*SizeConfig.widthMultiplier, right: 4*SizeConfig.widthMultiplier),
      width: double.infinity,
      color: Colors.white,
      child: ListView.builder(
        itemCount: _gifs==null?0:_gifs.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.only(bottom: 2*SizeConfig.heightMultiplier),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5*SizeConfig.widthMultiplier),
              ),
              color: HexColor('f4f4f4'),
              child: Container(
                  padding: EdgeInsets.only(left: 2*SizeConfig.widthMultiplier, right: 2*SizeConfig.widthMultiplier, bottom: 1*SizeConfig.heightMultiplier),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: (){
                            FotoPop(_gifs[index]['images']['original']['url'].toString());
                          },
                          child: Icon(Icons.keyboard_control_outlined),
                        )
                      ),
                      Container(
                        child: Table(
                          children: [
                            TableRow(
                                children: [
                                  Container(
                                      height: 13*SizeConfig.heightMultiplier,
                                      child: Stack(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 2*SizeConfig.widthMultiplier, right: 2*SizeConfig.widthMultiplier),
                                            height: 10*SizeConfig.heightMultiplier,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage('${_gifs[index]['images']['original']['url']}'),
                                                    fit: BoxFit.fill
                                                ),
                                                borderRadius: BorderRadius.all(Radius.circular(5*SizeConfig.widthMultiplier))
                                            ),
                                          ),
                                          Positioned(
                                            top: 62,
                                            left: 65,
                                            child:Container(
                                              alignment: Alignment.center,
                                              child: InkWell(
                                                child: Container(
                                                  padding: EdgeInsets.all(2*SizeConfig.imageSizeMultiplier),
                                                  height: 5*SizeConfig.heightMultiplier,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                    boxShadow: kElevationToShadow[2],
                                                  ),
                                                  child: Icon(Icons.favorite, color: HexColor('e0844c'),),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 2*SizeConfig.widthMultiplier, right: 2*SizeConfig.widthMultiplier),
                                    child: Container(
                                      child: Text(""+_gifs[index]['title'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 2*SizeConfig.textMultiplier,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  )
                                ]
                            )
                          ],
                        ),
                      )
                    ],
                  )
              )
          );
        },
      ),
    );

    return WillPopScope(
      onWillPop: ()=> exit(0),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Header,
                Favorite,
                Tabs,
                TitleList,
                _isLoading?Container(
                  margin: EdgeInsets.only(top: 15*SizeConfig.heightMultiplier),
                  alignment: Alignment.center,
                  child: Image(
                    height: 15*SizeConfig.heightMultiplier,
                    image: AssetImage('images/loading/loading2.gif'),
                    fit: BoxFit.cover
                  ),
                ):Container(
                  height: 44*SizeConfig.heightMultiplier,
                  child: ListApi,
                )
              ],
            ),
          )
        ),
        bottomNavigationBar: footerG,
      ),
    );
  }
}